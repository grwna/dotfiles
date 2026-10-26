#!/usr/bin/env python3
"""Automated skill updater using skills.manifest.yaml and skills.lock.json.

Downloads upstream repositories and updates skill directories with verbose progress.
Uses a lockfile to track remote commit SHAs and avoid redundant downloads.
"""

from __future__ import annotations

import argparse
import filecmp
import io
import json
import os
import shutil
import subprocess
import sys
import tarfile
import tempfile
import time
import urllib.error
import urllib.request
from collections import defaultdict
from pathlib import Path
from typing import Any

try:
    import yaml
except ImportError:
    print("Error: PyYAML is required. Please install with: pip install pyyaml", file=sys.stderr)
    sys.exit(1)


def parse_arguments() -> argparse.Namespace:
    parser = argparse.ArgumentParser(
        description=(
            "Update skills from upstream sources defined in skills.manifest.yaml.\n\n"
            "Synopsis:\n"
            "  update-skills.py [-f] [-d] [-a | <skill>...]\n"
            "  update-skills.py -l | --list\n\n"
            "Compatibility:\n"
            "  * [-f] and [-d] can be combined together with any target (e.g. -af, -fd, -afd).\n"
            "  * [-a] and [<skill>...] are mutually exclusive targets (pass -a OR skill names).\n"
            "  * [-l] is a standalone query mode (cannot be combined with update actions)."
        ),
        formatter_class=argparse.RawDescriptionHelpFormatter,
    )
    parser.add_argument(
        "skills",
        nargs="*",
        help="Optional specific skill names to update. If omitted, updates all upstream skills.",
    )
    parser.add_argument(
        "-a",
        "--all",
        action="store_true",
        help="Update all skills defined in the manifest.",
    )
    parser.add_argument(
        "-f",
        "--force",
        action="store_true",
        help="Force download and sync even if upstream commit matches lockfile.",
    )
    parser.add_argument(
        "--manifest",
        type=Path,
        default=None,
        help="Path to skills.manifest.yaml (default: ~/.grwna-agents/skills.manifest.yaml)",
    )
    parser.add_argument(
        "--lockfile",
        type=Path,
        default=None,
        help="Path to skills.lock.json (default: alongside skills.manifest.yaml)",
    )
    parser.add_argument(
        "--skills-dir",
        type=Path,
        default=None,
        help="Path to target skills directory (default: ~/.grwna-agents/skills)",
    )
    parser.add_argument(
        "-d",
        "--dry-run",
        action="store_true",
        help="Simulate the update process without modifying files on disk.",
    )
    parser.add_argument(
        "-l",
        "--list",
        action="store_true",
        help="List all skills defined in the manifest and their sources.",
    )
    return parser.parse_args()


def load_manifest(manifest_path: Path) -> dict[str, Any]:
    if not manifest_path.exists():
        raise FileNotFoundError(f"Manifest not found: {manifest_path}")
    with open(manifest_path, "r", encoding="utf-8") as f:
        data = yaml.safe_load(f) or {}
    return data


def load_lockfile(lockfile_path: Path) -> dict[str, str]:
    if not lockfile_path.exists():
        return {}
    try:
        with open(lockfile_path, "r", encoding="utf-8") as f:
            return json.load(f)
    except Exception as exc:
        print(f"Warning: Could not read lockfile ({exc}), ignoring.", file=sys.stderr)
        return {}


def save_lockfile(lockfile_path: Path, data: dict[str, str]) -> None:
    try:
        lockfile_path.parent.mkdir(parents=True, exist_ok=True)
        with open(lockfile_path, "w", encoding="utf-8") as f:
            json.dump(data, f, indent=2, sort_keys=True)
            f.write("\n")
    except Exception as exc:
        print(f"Warning: Could not write lockfile ({exc}).", file=sys.stderr)


def get_remote_commit_sha(repo: str, ref: str) -> str | None:
    candidates = [
        f"refs/heads/{ref}",
        f"refs/tags/{ref}",
        ref,
    ]
    try:
        cmd = ["git", "ls-remote", f"https://github.com/{repo}.git", *candidates]
        res = subprocess.run(cmd, capture_output=True, text=True, timeout=15, check=False)
        if res.returncode == 0 and res.stdout.strip():
            for line in res.stdout.strip().splitlines():
                parts = line.split()
                if len(parts) >= 2:
                    ref_name = parts[1]
                    if (
                        ref_name == f"refs/heads/{ref}"
                        or ref_name == f"refs/tags/{ref}"
                        or ref_name.endswith(f"/{ref}")
                    ):
                        return parts[0]
            lines = res.stdout.strip().splitlines()
            if lines and lines[0].split():
                return lines[0].split()[0]
    except Exception:
        pass

    try:
        url = f"https://api.github.com/repos/{repo}/commits/{ref}"
        req = urllib.request.Request(
            url,
            headers={
                "User-Agent": "agent-skill-updater",
                "Accept": "application/vnd.github.sha",
            },
        )
        with urllib.request.urlopen(req, timeout=15) as resp:
            return resp.read().decode("utf-8").strip()
    except Exception:
        pass

    return None


def format_bytes(size: int) -> str:
    if size < 1024:
        return f"{size} B"
    if size < 1024 * 1024:
        return f"{size / 1024:.1f} KB"
    return f"{size / (1024 * 1024):.2f} MB"


def download_repo_archive(repo: str, ref: str) -> tuple[tarfile.TarFile, str, int]:
    url_candidates = [
        f"https://github.com/{repo}/archive/refs/tags/{ref}.tar.gz",
        f"https://github.com/{repo}/archive/refs/heads/{ref}.tar.gz",
        f"https://github.com/{repo}/archive/{ref}.tar.gz",
    ]

    last_error: Exception | None = None
    headers = {"User-Agent": "agent-skill-updater"}

    for url in url_candidates:
        print(f"  -> Attempting download from: {url}")
        start_time = time.time()
        try:
            req = urllib.request.Request(url, headers=headers)
            with urllib.request.urlopen(req, timeout=30) as resp:
                content = resp.read()
                elapsed = time.time() - start_time
                print(f"  -> Successfully downloaded {format_bytes(len(content))} in {elapsed:.2f}s")
                archive = tarfile.open(fileobj=io.BytesIO(content), mode="r:gz")
                return archive, url, len(content)
        except urllib.error.HTTPError as exc:
            last_error = exc
            if exc.code == 404:
                print(f"     (404 Not Found, checking next candidate...)")
                continue
            raise
        except Exception as exc:
            last_error = exc
            break

    raise RuntimeError(f"Failed to download repository {repo} (ref: {ref}): {last_error}")


def get_directory_changes(src: Path, dst: Path) -> list[str]:
    if not dst.exists():
        files = [p for p in src.rglob("*") if p.is_file()]
        return [f"+ {p.relative_to(src)}" for p in files]

    changes: list[str] = []
    cmp = filecmp.dircmp(src, dst)

    for item in cmp.left_only:
        p = src / item
        if p.is_dir():
            changes.extend([f"+ {sub.relative_to(src)}" for sub in p.rglob("*") if sub.is_file()])
        else:
            changes.append(f"+ {p.relative_to(src)}")

    for item in cmp.right_only:
        p = dst / item
        if p.is_dir():
            changes.extend([f"- {sub.relative_to(dst)}" for sub in p.rglob("*") if sub.is_file()])
        else:
            changes.append(f"- {p.relative_to(dst)}")

    for item in cmp.diff_files:
        changes.append(f"~ {(src / item).relative_to(src)}")

    for common_dir in cmp.common_dirs:
        changes.extend(get_directory_changes(src / common_dir, dst / common_dir))

    return changes


def count_files_in_dir(path: Path) -> int:
    if not path.exists():
        return 0
    return sum(1 for p in path.rglob("*") if p.is_file())


def sync_directory(src: Path, dst: Path, dry_run: bool) -> tuple[bool, bool, list[str]]:
    is_new = not dst.exists()
    changes = get_directory_changes(src, dst)
    changed = is_new or len(changes) > 0

    if changed and not dry_run:
        if dst.exists():
            shutil.rmtree(dst)
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(src, dst, ignore=shutil.ignore_patterns(".git*", ".github*"))

    return changed, is_new, changes


def list_manifest_skills(manifest_data: dict[str, Any], lock_data: dict[str, str]) -> None:
    skills = manifest_data.get("skills", {})
    print(f"Total skills defined: {len(skills)}\n")

    rows: list[tuple[str, str, str, str]] = [("Skill", "Type", "Source", "Locked Commit")]
    for name, info in sorted(skills.items()):
        if info.get("local", False):
            rows.append((name, "local", "-", "-"))
        else:
            repo = info.get("repo", "unknown")
            ref = info.get("ref", "main")
            path = info.get("path", "")
            source_str = f"{repo}@{ref} ({path})"
            locked_commit = lock_data.get(f"{repo}@{ref}", "not locked")
            locked_display = locked_commit[:9] if locked_commit != "not locked" else locked_commit
            rows.append((name, "upstream", source_str, locked_display))

    widths = [max(len(row[i]) for row in rows) for i in range(4)]
    sep = "  "
    print(sep.join(val.ljust(widths[i]) for i, val in enumerate(rows[0])).rstrip())
    print(sep.join("-" * widths[i] for i in range(4)))
    for row in rows[1:]:
        print(sep.join(val.ljust(widths[i]) for i, val in enumerate(row)).rstrip())


def main() -> int:
    args = parse_arguments()

    home_agents = Path.home() / ".grwna-agents"

    manifest_path = args.manifest or (home_agents / "skills.manifest.yaml")
    lockfile_path = args.lockfile or (manifest_path.parent / "skills.lock.json")
    skills_dir = args.skills_dir or (home_agents / "skills")

    print(f"==> Skill Manifest: {manifest_path}")
    print(f"==> Lockfile:       {lockfile_path}")
    print(f"==> Skills Target:  {skills_dir}")
    if args.dry_run:
        print("==> Mode: DRY RUN (no files will be written)")
    if args.force:
        print("==> Force mode enabled (bypassing lockfile cache)")

    try:
        manifest = load_manifest(manifest_path)
    except Exception as exc:
        print(f"Error loading manifest: {exc}", file=sys.stderr)
        return 1

    lock_data = load_lockfile(lockfile_path)

    if args.list:
        list_manifest_skills(manifest, lock_data)
        return 0

    defined_skills: dict[str, dict[str, Any]] = manifest.get("skills", {})

    target_names = list(defined_skills.keys()) if (args.all or not args.skills) else args.skills

    unknown_names = [name for name in target_names if name not in defined_skills]
    if unknown_names:
        print(f"Warning: The following skills are not in the manifest: {', '.join(unknown_names)}")

    repo_groups: dict[tuple[str, str], list[tuple[str, dict[str, Any]]]] = defaultdict(list)
    local_count = 0

    for name in target_names:
        info = defined_skills.get(name)
        if not info:
            continue

        if info.get("local", False):
            local_count += 1
            print(f" [SKIP] {name} (configured as local/custom skill)")
            continue

        repo = info.get("repo")
        ref = info.get("ref", "main")
        if not repo:
            print(f" [WARN] {name} has no repo defined in manifest, skipping.")
            continue

        repo_groups[(repo, ref)].append((name, info))

    if not repo_groups:
        print("No upstream skills to update.")
        return 0

    total_updated = 0
    total_unchanged = 0
    total_skipped_locked = 0
    total_errors = 0
    lock_data_updated = False

    for (repo, ref), skills_in_repo in repo_groups.items():
        repo_key = f"{repo}@{ref}"
        skill_names_str = ", ".join(name for name, _ in skills_in_repo)
        print(f"\n=======================================================")
        print(f"Repository: {repo} (ref: {ref})")
        print(f"Target skill(s) [{len(skills_in_repo)}]: {skill_names_str}")
        print(f"=======================================================")

        remote_sha = get_remote_commit_sha(repo, ref)
        locked_sha = lock_data.get(repo_key)

        # Check if local folders exist for all requested skills in this repo
        all_local_exist = all((skills_dir / name).exists() for name, _ in skills_in_repo)

        if not args.force and remote_sha and locked_sha and remote_sha == locked_sha and all_local_exist:
            print(f"  -> Upstream commit unchanged ({remote_sha[:9]}).")
            print(f"  -> Skipping download (all target skills exist locally and match lockfile).")
            for name, _ in skills_in_repo:
                dst_path = skills_dir / name
                file_count = count_files_in_dir(dst_path)
                print(f"     [OK] {name} is up-to-date ({file_count} file(s))")
                total_unchanged += 1
                total_skipped_locked += 1
            continue

        if remote_sha:
            if locked_sha and locked_sha != remote_sha:
                print(f"  -> Upstream commit changed: {locked_sha[:9]} -> {remote_sha[:9]}")
            else:
                print(f"  -> Remote commit resolved: {remote_sha[:9]}")

        try:
            archive, resolved_url, download_size = download_repo_archive(repo, ref)
        except Exception as exc:
            print(f" [ERROR] Could not fetch {repo}: {exc}", file=sys.stderr)
            total_errors += len(skills_in_repo)
            continue

        repo_sync_success = True

        with tempfile.TemporaryDirectory() as tmp_dir:
            print(f"  -> Extracting archive to temporary workspace...")
            archive.extractall(path=tmp_dir)
            top_levels = [d for d in os.listdir(tmp_dir) if os.path.isdir(os.path.join(tmp_dir, d))]
            if not top_levels:
                print(f" [ERROR] Extracted archive was empty for {repo}", file=sys.stderr)
                total_errors += len(skills_in_repo)
                continue

            extracted_root = Path(tmp_dir) / top_levels[0]

            for name, info in skills_in_repo:
                subpath = info.get("path")
                if subpath is None:
                    subpath = f"skills/{name}"

                subpath_clean = subpath.strip("/")
                if subpath_clean in ("", "."):
                    src_path = extracted_root
                else:
                    src_path = extracted_root / subpath_clean

                dst_path = skills_dir / name

                print(f"\n  * Skill: {name}")
                print(f"    Source path: {subpath or '/'}")
                print(f"    Destination: {dst_path}")

                if not src_path.exists():
                    print(f"    [FAIL] Source path '{subpath}' does not exist in {repo}")
                    total_errors += 1
                    repo_sync_success = False
                    continue

                try:
                    changed, is_new, changes = sync_directory(src_path, dst_path, args.dry_run)
                    if changed:
                        action_label = "WOULD INSTALL" if args.dry_run else ("INSTALLED" if is_new else "UPDATED")
                        print(f"    [{action_label}] {len(changes)} file(s) changed:")
                        display_changes = changes[:12]
                        for c in display_changes:
                            print(f"      {c}")
                        if len(changes) > 12:
                            print(f"      ... and {len(changes) - 12} more file(s)")
                        total_updated += 1
                    else:
                        file_count = count_files_in_dir(dst_path)
                        print(f"    [OK] Up-to-date ({file_count} file(s) match upstream)")
                        total_unchanged += 1
                except Exception as exc:
                    print(f"    [ERROR] Failed to update {name}: {exc}", file=sys.stderr)
                    total_errors += 1
                    repo_sync_success = False

        if repo_sync_success and remote_sha and not args.dry_run:
            lock_data[repo_key] = remote_sha
            lock_data_updated = True

    if lock_data_updated and not args.dry_run:
        save_lockfile(lockfile_path, lock_data)
        print(f"\n==> Updated lockfile at: {lockfile_path}")

    mode_suffix = " (dry run)" if args.dry_run else ""
    print(f"\n-------------------------------------------------------")
    print(f"Summary{mode_suffix}:")
    print(f"  Updated:           {total_updated}")
    print(f"  Unchanged:         {total_unchanged} ({total_skipped_locked} skipped via lockfile)")
    print(f"  Skipped (local):   {local_count}")
    if total_errors > 0:
        print(f"  Errors:            {total_errors}")
    print(f"-------------------------------------------------------")

    return 1 if total_errors > 0 else 0


if __name__ == "__main__":
    sys.exit(main())

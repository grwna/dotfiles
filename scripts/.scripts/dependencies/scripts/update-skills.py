#!/usr/bin/env python3
"""Automated skill updater using skills.manifest.yaml.

Downloads upstream repositories and updates skill directories.
"""

from __future__ import annotations

import argparse
import filecmp
import io
import os
import shutil
import sys
import tarfile
import tempfile
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
    parser = argparse.ArgumentParser(description="Update skills from upstream sources defined in manifest.")
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
        "--manifest",
        type=Path,
        default=None,
        help="Path to skills.manifest.yaml (default: ~/.grwna-agents/skills.manifest.yaml)",
    )
    parser.add_argument(
        "--skills-dir",
        type=Path,
        default=None,
        help="Path to target skills directory (default: ~/.grwna-agents/skills)",
    )
    parser.add_argument(
        "--dry-run",
        action="store_true",
        help="Simulate the update process without modifying files on disk.",
    )
    parser.add_argument(
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


def download_repo_archive(repo: str, ref: str) -> tarfile.TarFile:
    url_candidates = [
        f"https://github.com/{repo}/archive/refs/tags/{ref}.tar.gz",
        f"https://github.com/{repo}/archive/refs/heads/{ref}.tar.gz",
        f"https://github.com/{repo}/archive/{ref}.tar.gz",
    ]

    last_error: Exception | None = None
    headers = {"User-Agent": "agent-skill-updater"}

    for url in url_candidates:
        try:
            req = urllib.request.Request(url, headers=headers)
            with urllib.request.urlopen(req, timeout=30) as resp:
                content = resp.read()
                return tarfile.open(fileobj=io.BytesIO(content), mode="r:gz")
        except urllib.error.HTTPError as exc:
            last_error = exc
            if exc.code == 404:
                continue
            raise
        except Exception as exc:
            last_error = exc
            break

    raise RuntimeError(f"Failed to download repository {repo} (ref: {ref}): {last_error}")


def has_directory_diff(src: Path, dst: Path) -> bool:
    if not dst.exists():
        return True

    cmp = filecmp.dircmp(src, dst)
    if cmp.left_only or cmp.right_only or cmp.diff_files:
        return True

    for common_dir in cmp.common_dirs:
        if has_directory_diff(src / common_dir, dst / common_dir):
            return True

    return False


def sync_directory(src: Path, dst: Path, dry_run: bool) -> tuple[int, int]:
    changed = False
    is_new = not dst.exists()

    if is_new or has_directory_diff(src, dst):
        changed = True

    if changed and not dry_run:
        if dst.exists():
            shutil.rmtree(dst)
        dst.parent.mkdir(parents=True, exist_ok=True)
        shutil.copytree(src, dst, ignore=shutil.ignore_patterns(".git*", ".github*"))

    return (1 if changed else 0, 1 if is_new else 0)


def list_manifest_skills(manifest_data: dict[str, Any]) -> None:
    skills = manifest_data.get("skills", {})
    print(f"Total skills defined: {len(skills)}\n")
    print(f"{'Skill':<35} {'Type':<10} {'Source'}")
    print("-" * 75)
    for name, info in sorted(skills.items()):
        if info.get("local", False):
            print(f"{name:<35} {'local':<10} -")
        else:
            repo = info.get("repo", "unknown")
            ref = info.get("ref", "main")
            path = info.get("path", "")
            print(f"{name:<35} {'upstream':<10} {repo}@{ref} ({path})")


def main() -> int:
    args = parse_arguments()

    home_agents = Path.home() / ".grwna-agents"

    manifest_path = args.manifest or (home_agents / "skills.manifest.yaml")
    skills_dir = args.skills_dir or (home_agents / "skills")

    try:
        manifest = load_manifest(manifest_path)
    except Exception as exc:
        print(f"Error loading manifest: {exc}", file=sys.stderr)
        return 1

    if args.list:
        list_manifest_skills(manifest)
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
    total_errors = 0

    for (repo, ref), skills_in_repo in repo_groups.items():
        print(f"\nFetching {repo} ({ref}) for {len(skills_in_repo)} skill(s)...")
        try:
            archive = download_repo_archive(repo, ref)
        except Exception as exc:
            print(f" [ERROR] Could not fetch {repo}: {exc}", file=sys.stderr)
            total_errors += len(skills_in_repo)
            continue

        with tempfile.TemporaryDirectory() as tmp_dir:
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

                if not src_path.exists():
                    print(f" [FAIL] {name}: path '{subpath}' not found in {repo}")
                    total_errors += 1
                    continue

                try:
                    changed, is_new = sync_directory(src_path, dst_path, args.dry_run)
                    if changed:
                        action = "WOULD INSTALL" if args.dry_run else ("INSTALLED" if is_new else "UPDATED")
                        print(f" [{action}] {name}")
                        total_updated += 1
                    else:
                        print(f" [OK] {name} (up-to-date)")
                        total_unchanged += 1
                except Exception as exc:
                    print(f" [ERROR] Failed to update {name}: {exc}", file=sys.stderr)
                    total_errors += 1

    mode_suffix = " (dry run)" if args.dry_run else ""
    print(f"\nSummary{mode_suffix}:")
    print(f"  Updated:   {total_updated}")
    print(f"  Unchanged: {total_unchanged}")
    print(f"  Skipped:   {local_count} (local)")
    if total_errors > 0:
        print(f"  Errors:    {total_errors}")

    return 1 if total_errors > 0 else 0


if __name__ == "__main__":
    sys.exit(main())

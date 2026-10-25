- Do not execute any non-read-only git commands (git mv, commit, push. git fetch, diff etc. are okay).

## Skill Management

When requested to install or register skills into the manifest given a list of skill names and a repository URL:
1. Parse the repository URL (e.g., `https://github.com/<owner>/<repo>`) into `<owner>/<repo>`.
2. Inspect the repository to identify the release ref (query GitHub releases/tags or default branch `main`) and locate each target skill's subpath (e.g., `skills/<skill_name>` or `""` if at repo root).
3. Add the skill entry to `skills.manifest.yaml`:
   ```yaml
   <skill_name>:
     repo: "<owner>/<repo>"
     ref: "<release-tag-or-branch>"
     path: "<path-inside-repo>"
     description: "<short description>"
   ```
4. Run `ag update <skill_name>` (or `ag update --dry-run <skill_name>` to verify) to download and install the skills.

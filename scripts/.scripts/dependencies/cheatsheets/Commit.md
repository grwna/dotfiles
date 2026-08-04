# Conventional Commits

| Prefix | Description |
|--------|-------------|
| `feat:` | New feature |
| `fix:` | Bug fix |
| `docs:` | Documentation only |
| `style:` | Formatting, no behavior change |
| `refactor:` | Neither fix nor feature |
| `perf:` | Performance improvement |
| `test:` | Add or correct tests |
| `build:` | Build system or dependencies |
| `ci:` | CI/CD config |
| `chore:` | Routine maintenance |

## Format

```
<type>(<scope>): <short description>

<body>

<footer>
```

- **scope** optional, in parentheses
- **breaking change** add `!` after type or `BREAKING CHANGE:` in footer
- **issue ref** `Closes #123` in footer

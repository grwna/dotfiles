# Grep Cheatsheets

`[]` - denotes parameters
`<>` - denotes optional parameters

# Basic Usage

| command                    | description                       |
| -------------------------- | --------------------------------- |
| `grep [pattern] [file]`    | search pattern in file            |
| `grep -r [pattern] [dir]`  | recursive search                  |
| `grep -i [pattern] [file]` | case-insensitive                  |
| `grep -v [pattern] [file]` | invert match (non-matching lines) |
| `grep -n [pattern] [file]` | show line numbers                 |
| `grep -c [pattern] [file]` | count matching lines              |
| `grep -l [pattern] [dir]`  | print only filenames with matches |
| `grep -R [pattern] [dir]`  | recursive, follow symlinks        |

# Combined Flags

| command                    | description                 |
| -------------------------- | --------------------------- |
| `grep -rn [pattern] [dir]` | recursive with line numbers |
| `grep -ri [pattern] [dir]` | recursive, case-insensitive |
| `grep -rl [pattern] [dir]` | recursive, filenames only   |

# Patterns

| flag     | desc                       |
| -------- | -------------------------- |
| `^`      | start of line              |
| `$`      | end of line                |
| `.`      | any single character       |
| `*`      | zero or more of preceding  |
| `+`      | one or more of preceding   |
| `\|`     | OR (escape in basic regex) |
| `[abc]`  | any of a, b, or c          |
| `[^abc]` | any char except a, b, c    |

# Useful Variants

| command                  | description                               |
| ------------------------ | ----------------------------------------- |
| `rg [pattern] [dir]`     | ripgrep (faster, recursive by default)    |
| `egrep [pattern] [file]` | extended regex (no need to escape `\|{}`) |
| `fgrep [pattern] [file]` | fixed string search (no regex)            |

# Notes
- Use `-w` for whole-word matching
- Use `--color` to highlight matches in terminal
- `grep -2` shows 2 lines of context around matches
- Use `grep -e [pattern]` to search for multiple patterns

# Find Cheatsheets

`[]` - denotes parameters
`<>` - denotes optional parameters

# Basic Usage

| command                    | description                     |
| -------------------------- | ------------------------------- |
| `find [dir] -name [file]`  | find file by name               |
| `find [dir] -name "*.txt"` | find by extension               |
| `find [dir] -iname [file]` | case-insensitive name match     |
| `find [dir] -type f`       | find only files                 |
| `find [dir] -type d`       | find only directories           |
| `find [dir] -empty`        | find empty files or directories |

# By Size

| command                  | description                |
| ------------------------ | -------------------------- |
| `find [dir] -size +[N]c` | files larger than N bytes  |
| `find [dir] -size -[N]c` | files smaller than N bytes |
| `find [dir] -size +[N]k` | files larger than N KB     |
| `find [dir] -size +[N]M` | files larger than N MB     |

# By Time

| command                  | description                    |
| ------------------------ | ------------------------------ |
| `find [dir] -mtime -[N]` | modified within last N days    |
| `find [dir] -mtime +[N]` | modified more than N days ago  |
| `find [dir] -mmin -[N]`  | modified within last N minutes |
| `find [dir] -atime [N]`  | accessed N days ago            |

# By Permissions

| command                 | description                  |
| ----------------------- | ---------------------------- |
| `find [dir] -perm 644`  | files with exact permissions |
| `find [dir] -perm -u+x` | files executable by owner    |
| `find [dir] -perm /u+x` | files executable by anyone   |

# Actions

| command                        | description                    |
| ------------------------------ | ------------------------------ |
| `find [dir] -delete`           | delete matched files           |
| `find [dir] -exec [cmd] {} \;` | run command on each match      |
| `find [dir] -exec [cmd] {} +`  | run command on grouped matches |
| `find [dir] -print`            | print paths (default)          |

# Combining

| command                                           | description        |
| ------------------------------------------------- | ------------------ |
| `find [dir] -name "*.txt" -type f`                | txt files only     |
| `find [dir] -name "*.log" -mtime +7`              | old log files      |
| `find [dir] \( -name "*.tmp" -o -name "*.bak" \)` | match .tmp OR .bak |

# Notes
- `{}` in `-exec` refers to the current file path
- Escape `\( \)` for grouping OR conditions
- `-print0` with `xargs -0` handles filenames with spaces
- Use `-depth` to traverse directories bottom-up before top-down

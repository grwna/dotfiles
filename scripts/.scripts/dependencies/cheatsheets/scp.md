# SCP Cheatsheets

`[]` - denotes parameters
`<>` - denotes optional parameters

# Basic Usage

| command                                    | description                      |
| ------------------------------------------ | -------------------------------- |
| `scp [file] [user]@[host]:[path]`          | copy file to remote host         |
| `scp [user]@[host]:[file] [path]`          | copy file from remote host       |
| `scp [file1] [file2] [user]@[host]:[path]` | copy multiple files to remote    |
| `scp [user]@[host]:[dir] [path]`           | copy remote directory (use `-r`) |

# Recursive Copy

| command                             | description                |
| ----------------------------------- | -------------------------- |
| `scp -r [dir] [user]@[host]:[path]` | copy directory recursively |

# Common Flags

| flag        | description                            |
| ----------- | -------------------------------------- |
| `-r`        | recursive (for directories)            |
| `-P [port]` | specify port (uppercase P)             |
| `-p`        | preserve timestamps and modes          |
| `-i [key]`  | specify identity file (key-based auth) |
| `-C`        | compress data during transfer          |
| `-q`        | quiet mode (no progress)               |

# Common Patterns

| command                                     | description                        |
| ------------------------------------------- | ---------------------------------- |
| `scp -r [dir] [user]@[host]:~/`             | copy dir to remote home            |
| `scp -P [port] [file] [user]@[host]:[path]` | copy using custom port             |
| `scp -i [key] [file] [user]@[host]:[path]`  | copy using SSH key                 |
| `scp -r -C [dir] [user]@[host]:[path]`      | compress while copying recursively |

# Notes
- Default SSH port is 22; use `-P` for custom ports
- `~` refers to the remote user's home directory
- SCP preserves file permissions by default with `-p`
- Use `scp -3` to route through an intermediate host
- Ensure `~/.ssh/config` is configured for frequently used hosts

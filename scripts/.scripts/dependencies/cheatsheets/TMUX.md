# TMUX Cheatsheets 
[] - denotes parameters
<> - denotes optional parameters

# Basic Commands

| command  | description                      |
| -------- | -------------------------------- |
| Ctrl-b   | prefix (will be denoted as p:)   |
| p: ?     | help                             |
| p: :     | command prompt                   |


# Pane Management
| command         | description                        |
| --------------- | ---------------------------------- |
| p: %            | horizontal split                   |
| p: "            | vertical split                     |
| p: z            | toggle maximize current pane       |
| p: x            | close pane                         |
| p: !            | move pane to new window            |
| p: h\|j\|k\|l   | navigate panes                     |
| p: H\|J\|K\|L   | resize panes (5)                   |
| p: Ctrl + h\|j\|k\|l   | resize panes (1)                   |
| p: ;            | toggle current and last pane       |
| p: space        | cycle through layout               |
| p: {\|}         | move current pane backward/forward |


# Window Management
| commands         | description                    |
| ---------------- | ------------------------------ |
| p: c             | create new window              |
| p: n             | next window                    |
| p: p             | previous window                |
| p: [number]      | go to i-th window              |
| p: ,             | rename current window          |
| exit or p: &     | close window                   |
| p: l             | toggle current and last window |
| p: w             | list all windows and sessions  |
| p: ,             | rename current window          |


# Session Management
| commands                     | description            |
| ---------------------------- | ---------------------- |
| tmux new -s [session_name]   | creates new sessions   |
| tmux a <-t [session_name]>   | attach to session      |
| tmux ls                      | list sessions          |
| tmux kill-session                      | kill sessions          |
| p: d                         | detach from session    |
| p: s                         | switch sessions        |
| p: $                         | rename current session |


# Copy Mode & Scroll

copy mode uses vim motions
| command   | description       |
| --------- | ----------------- |
| p: [      | enter copy mode   |
| p: ]      | paste             |
| p: #      | list copy buffers |
| p: PgUp   | scroll up         |


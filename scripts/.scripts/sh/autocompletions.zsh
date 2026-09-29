# Generic completion helper for single-argument directory file listing
_path_file_completion_helper() {
    # Only run autocompletion for the FIRST argument after 'cs'
    (( CURRENT == 2 )) || return 0

    local target_dir="$1"
    [ -d "$target_dir" ] || return 0

    local -a items
    items=("$target_dir"/*(N.:t:r))

    # Pass case-insensitive matcher to compadd
    compadd -M 'm:{a-zA-Z}={A-Za-z}' -a items
}

_tm_completions() {
    _path_file_completion_helper "$HOME/.scripts/dependencies/templates/"
}

_cs_completions() {
    _path_file_completion_helper "$HOME/.scripts/dependencies/cheatsheets/"
    
}
_gw_completions() {
    _path_file_completion_helper "$HOME/.scripts/bin/"
}

compdef _tm_completions tm
compdef _cs_completions cs
compdef _gw_completions gw

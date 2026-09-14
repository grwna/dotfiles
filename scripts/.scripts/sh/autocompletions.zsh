_tm_completions() {
    # Only run autocompletion for the FIRST argument after 'tm'
    (( CURRENT == 2 )) || return 0

    local BASE_DIR="$HOME/.scripts/dependencies/templates/"
    [ -d "$BASE_DIR" ] || return 0

    local -a templates
    templates=("$BASE_DIR"/*(N.:t:r))

    compadd -a templates
}

compdef _tm_completions tm


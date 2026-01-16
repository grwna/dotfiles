#!/bin/bash


# ==========================
# Functions
# ==========================
EXCLUDED_DIRS=(
    "others"
    "vscode"
)

# Ensure we are in the correct directory
cd "$(dirname "${BASH_SOURCE[0]}")" || exit 1

is_excluded() {
    local dir_name="$1"
    for excluded in "${EXCLUDED_DIRS[@]}"; do
        if [[ "$dir_name" == "$excluded" ]]; then
            return 0
        fi
    done
    return 1
}

get_all_configs() {
    local packages=()
    for dir in */; do
        local pkg_name="${dir%/}"

        if [[ $pkg_name == .* ]]; then continue; fi

        if ! is_excluded "$pkg_name"; then
            packages+=("$pkg_name")
        fi
    done
    echo "${packages[@]}"
}

install_config() {
    local package="$1"
    if [ ! -d "$package" ]; then
        echo " [SKIPPING] Config directory '$package' not found"
        return
    fi

    if  is_excluded "$package"; then
        echo " [SKIPPING] Config is not installable"
        return
    fi

    echo "  -> Stowing: $package"
    stow -v -R -t ~ "$package"
}

# ==========================
# Main
# ==========================
# If no arguments are provided, print usage
if [ -z "$1" ]; then
    echo "Usage: ./install.sh <component> [component...] or ./install.sh all"
    echo "Example: ./install.sh nvim bash"
    echo ""
    echo "Available packages:"
    echo " $(get_all_configs)"
    exit 1
fi

TARGETS=()

if [ "$1" == "all" ]; then
    TARGETS=($(get_all_configs))
else
    TARGETS=("$@")
fi

echo "This script will install the following configs: "
echo "  ${TARGETS[*]}"
echo "Installation is done with symlink through stow."
echo "If the directory exists in your config folder, it is recommended to delete them first, this is due to how stow treats existing paths."
read -p "Proceed? [Y/n] " confirm

# Check the user's response
case "$confirm" in
# If 'y', 'Y', or just Enter is pressed, continue
[yY] | "")
    echo "Starting installation..."
    ;;
# For any other input, abort
*)
    echo "Aborted."
    exit 0
    ;;
esac

# Loop through all provided arguments
for component in "${TARGETS[@]}"; do
    install_config $component
done

echo ""
echo "Done!"

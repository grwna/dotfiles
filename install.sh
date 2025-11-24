#!/bin/bash

# Determine installation script's directory
DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

install_config() {
    local name="$1"
    local source="$2"
    local dest="$3"

    echo "Installing $name configs"

    # remove old configs
    if [ -e "$dest" ] || [ -L "$dest" ]; then
        echo "  Removing existing config at: $dest"
        rm -rf "$dest"
    fi

    # Create parent directory if not exist
    mkdir -p "$(dirname "$dest")"

    # Create symlink
    ln -sv "$source" "$dest"
    echo ""
}

install_zsh() {
    install_config "Zsh" "$DIR/zsh" "$HOME/.config/zsh"
}

install_zsh_simple() {
    install_config "Zsh-simple" "$DIR/zsh-simple/.zshrc" "$HOME/.zshrc"
}

install_nvim() {
    install_config "Neovim" "$DIR/nvim" "$HOME/.config/nvim"
}

install_hypr() {
    install_config "Hyprland" "$DIR/hypr" "$HOME/.config/hypr"
}

install_waybar() {
    install_config "Waybar" "$DIR/waybar" "$HOME/.config/waybar"
}

# These two were already correct because they specified the full path
install_zsh-simple() {
    install_config "Zsh-simple" "$DIR/zsh-simple/.zshrc" "$HOME/.zshrc"
}

install_bash() {
    install_config "Bash" "$DIR/bash/.bashrc" "$HOME/.bashrc"
}

install_kitty() {
    install_config "Kitty" "$DIR/kitty" "$HOME/.config/kitty"
}

install_fastfetch() {
    install_config "Fastfetch" "$DIR/fastfetch" "$HOME/.config/fastfetch"
}

# If no arguments are provided, print usage
if [ -z "$1" ]; then
    echo "Usage: ./install.sh <component> [component...] or ./install.sh all"
    echo "Example: ./install.sh nvim bash"
    exit 1
fi

echo "This script will install the following components: $@"
echo "Installation is one with symlink. If the directory exists in your config folder, they will be deleted."
read -p "Do you want to proceed with the installation? [Y/n] " confirm

# Check the user's response
case "$confirm" in
# If 'y', 'Y', or just Enter is pressed, continue
[yY] | "")
    echo "Starting installation..."
    ;;
# For any other input, abort
*)
    echo "Installation aborted by user."
    exit 0
    ;;
esac

# Loop through all provided arguments
for component in "$@"; do
    case $component in
    zsh)
        install_zsh
        ;;
    nvim)
        install_nvim
        ;;
    hypr)
        install_hypr
        ;;
    waybar)
        install_waybar
        ;;
    zsh-simple)
        install_zsh_simple
        ;;
    bash)
        install_bash
        ;;
    kitty)
        install_kitty
        ;;
    fastfetch)
        install_fastfetch
        ;;
    all)
        install_zsh
        install_nvim
        install_hypr
        install_waybar
        install_zsh-simple
        install_bash
        install_kitty
        install_fastfetch
        ;;
    *)
        echo "Unknown component: $component"
        ;;
    esac
done

install_zsh-simple() {
    echo "Installing Zsh-simple..."
    ln -s
}

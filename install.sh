#!/bin/bash

# Determine installation script's directory
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

install_zsh() {
    echo "Installing Zsh configs..."
    # Example: Symlink a specific file to the home directory
    ln -svf "$DIR/zsh" "$HOME/.config/zsh"
}

install_nvim() {
    echo "Installing Neovim configs..."
    # Example: Symlink an entire directory to ~/.config/
    mkdir -p "$HOME/.config"
    ln -svf "$DIR/nvim" "$HOME/.config/nvim"
}

install_hypr() {
    echo "Installing Hyprland configs..."
    # Example: Symlink an entire directory to ~/.config/
    mkdir -p "$HOME/.config"
    ln -svf "$DIR/hypr" "$HOME/.config/hypr"
}

install_waybar() {
    echo "Installing Waybar configs..."
    # Example: Symlink an entire directory to ~/.config/
    mkdir -p "$HOME/.config"
    ln -svf "$DIR/waybar" "$HOME/.config/waybar"
}

install_zsh-simple() {
    echo "Installing Zsh-simple configs..."
    # Example: Symlink a file from this directory
    ln -svf "$DIR/zsh-simple/.zshrc" "$HOME/.zshrc"
}

install_bash() {
    echo "Installing Bash configs..."
    ln -svf "$DIR/bash/.bashrc" "$HOME/.bashrc"
}

# If no arguments are provided, print usage
if [ -z "$1" ]; then
    echo "Usage: ./install.sh <component> [component...] or ./install.sh all"
    echo "Example: ./install.sh nvim bash"
    exit 1
fi

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
            install_zsh-simple
            ;;
        bash)
            install_bash
            ;;
        all)
            install_zsh
            install_nvim
            install_hypr
            install_waybar
            install_zsh-simple
            install_bash
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
# Dotfiles

My personal collection of dotfiles. This repository contains configurations for my development environment and system customization on Linux.

## 📖 How to Use

An automated installation script is provided that uses symlink to install specific configurations to their appropriate locations. If you would like to change the location, you would have to do so manually inside the script file: 'install.sh'.

### 1. Clone the repository

```bash
git clone https://github.com/grwna/dotfiles.git
cd dotfiles
```

### 2. Run the installation script

The script supports installing individual components or all of them at once.

**Usage:**

```bash
./install.sh <component> [component...]
```

**Examples:**

Install specific components:
```bash
./install.sh nvim zsh hypr
```

Install everything:
```bash
./install.sh all
```

**Available Components:**
- `zsh`
- `zsh-simple`
- `nvim`
- `cleanvim`
- `hypr`
- `waybar`
- `bash`
- `kitty`
- `fastfetch`
- `tmux`

> **Note:** The script will verify before removing any existing configurations in the target directories.

## ℹ️ Post-Installation Notes

### Cleanvim
If you installed `cleanvim`, you need to set the `NVIM_APPNAME` environment variable to use it. Add the following alias to your shell configuration (e.g., `.zshrc` or `.bashrc`):

```bash
alias cvim='NVIM_APPNAME=cleanvim nvim'
```

### Zsh
The `zsh` component installs configurations to `~/.config/zsh`. Ensure your system is set up to recognize `ZDOTDIR` or manually link `~/.zshenv` if necessary.

## 📂 Project Structure

```
├── assets/         # Text assets (ascii art)
├── bash/           # Bash configs
├── cleanvim/       # Clean Neovim configs
├── fastfetch/      # Fastfetch configs
├── hypr/           # Hyprland configs
├── kitty/          # Kitty terminal configs
├── nvim/           # Neovim configs
├── tmux/           # Tmux configs
├── waybar/         # Waybar configs
├── zsh/            # Zsh configs
└── install.sh      # Installation script
```

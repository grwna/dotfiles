# Dotfiles

>[!note]
> This is a deprecated version of my dotfiles, made when i was naive and didn't know the existence of [GNU Stow](https://www.gnu.org/software/stow/). 
> For the latest version, see [dotfiles](https://github.com/grwna/dotfiles/tree/main)

My personal collection of dotfiles. This repository contains configurations for my development environment and system customization on Linux.

## 📖 how to use
An automated installation script is provided that uses symlink to install specific configurations to their appropriate locations. if you would like to change the location, you would have to do so manually inside the script file: 'install.sh'.

### 1. clone the repository

```bash
git clone https://github.com/grwna/dotfiles.git
cd dotfiles
```

### 2. run the installation script

the script supports installing individual components or all of them at once.

**usage:**

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
To see a list of available components, you have to read the installation script

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

# Dotfiles

My personal collection of dotfiles. This repository contains configurations for my development environment and system customization on Linux.
Note that my main workflow

## Repository Structure
```
.
├── README.md
├── others
├── windows
├── install.sh
└── [installable configs]
```
- others: contains customization/ricing related things that are not configs
- windows: contains configs for my Windows setup

## 📖 how to use
An automated installation script is provided that uses stow to create symlinks for specific configurations to their appropriate locations. 

>[!tip]
> It is recommended to delete the directory of the config you want to install.

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
The components you can install are all directories in this repository except for `others` and `windows`


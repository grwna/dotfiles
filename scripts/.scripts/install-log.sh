#!/bin/bash
#
# --- Automatic Package Install Logger for apt and pacman ---
#
# This script defines a function that overrides the `sudo` command.
# When you run `sudo apt install ...` or `sudo pacman -S ...`, it logs
# the package names to a file before running the actual command.
#
# To use it, add the entire function to your ~/.bashrc or ~/.zshrc file,
# or save this file and source it from your shell configuration.
# Example: add `source /path/to/this/install_logger.sh` to ~/.bashrc

sudo() {
    # --- CONFIGURATION ---
    # You can change the path for your log file here if you wish.
    # Using ~/.local/share/ is a good practice to avoid cluttering your home directory.
    local LOG_FILE="$HOME/info/installed_packages.log"

    # --- SCRIPT LOGIC (No need to edit below this line) ---

    # Ensure the directory for the log file exists.
    # The -p flag creates parent directories if they don't exist.
    mkdir -p "$(dirname "$LOG_FILE")"

    local should_log_packages=false
    local packages_to_log=()
    local package_manager_name=""

    # Check for apt or apt-get install commands.
    if [[ ("$1" == "apt" || "$1" == "apt-get") && "$2" == "install" ]]; then
        should_log_packages=true
        package_manager_name="apt"
        # Get all arguments starting from the 3rd one (the package names).
        packages_to_log=("${@:3}")

    # Check if the command is for pacman/yay and contains the -S (Sync) flag.
    # This uses regex to catch -S, -Sy, -Syu, etc., as long as the arg starts with '-'.
    elif [[ ("$1" == "pacman" || "$1" == "yay") && "$2" =~ ^- && "$2" =~ S ]]; then
        should_log_packages=true
        package_manager_name="$1" # Dynamically set to 'pacman' or 'yay'
        # Get all arguments starting from the 3rd one (the package names).
        packages_to_log=("${@:3}")
    fi

    # If it was an install command, proceed with logging.
    if [ "$should_log_packages" = true ]; then
        echo "--> Logging packages to $LOG_FILE"
        for package in "${packages_to_log[@]}"; do
            # This check filters out arguments that start with a '-',
            # such as '-y' or '--force', so only package names are logged.
            if [[ ! "$package" =~ ^- ]]; then
                # The log entry format is: Timestamp - Package Manager - Package Name
                echo "$(date '+%Y-%m-%d %H:%M:%S') | $package_manager_name | $package" >>"$LOG_FILE"
            fi
        done
    fi

    # --- EXECUTION ---
    # This is the most important part: it executes the original command.
    # `command sudo` ensures we call the real sudo program and not this function,
    # which prevents an infinite loop.
    command sudo "$@"
}

# --- LOGGER FOR PYTHON PACKAGES (pip) ---
pip() {
    # Ensure the directory for the log file exists.
    local LOG_FILE="$HOME/info/installed_packages.log"
    mkdir -p "$(dirname "$LOG_FILE")"

    # Check if the command is 'pip install'. This will also work for 'pip3'.
    if [[ "$1" == "install" ]]; then
        echo "--> Logging pip packages to $LOG_FILE"
        # Use `basename` on `$0` to correctly identify if 'pip' or 'pip3' was used.
        local package_manager_name
        package_manager_name=$(basename "$0")
        
        # Get all arguments from the 2nd one onwards.
        local packages_to_log=("${@:2}")

        for package in "${packages_to_log[@]}"; do
            # Filter out flags (e.g., -r, --user, --upgrade) and file paths.
            # This prevents logging 'requirements.txt' or '.' as a package name.
            if [[ ! "$package" =~ ^- && "$package" != "." && "$package" != *".txt"* && "$package" != *"/"* ]]; then
                echo "$(date '+%Y-%m-%d %H:%M:%S') | $package_manager_name | $package" >>"$LOG_FILE"
            fi
        done
    fi

    # Execute the original pip command, preventing an infinite loop.
    command pip "$@"
}
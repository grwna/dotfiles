#!/bin/bash
#
# --- Automatic Package Install Logger for sudo (apt/pacman/yay), pip, and npm ---
#
# This script defines wrapper functions that intercept package installation commands
# and log the package names to a centralized file before running the actual command.
#
# To use it, add the functions to your ~/.bashrc or ~/.zshrc file,
# or save this file and source it from your shell configuration.
# Example: add `source /path/to/this/install-log.sh` to ~/.bashrc

sudo() {
    # --- CONFIGURATION ---
    # You can change the path for your log file here if you wish.
    # Using ~/.local/share/ is a good practice to avoid cluttering your home directory.
    local LOG_FILE="$HOME/info/installed_packages.log"

    # --- SCRIPT LOGIC ---
    # Ensure the directory for the log file exists.
    # The -p flag creates parent directories if they do not exist.
    mkdir -p "$(dirname "$LOG_FILE")"

    local should_log_packages=false
    local packages_to_log=()
    local package_manager_name=""

    # Check for apt or apt-get install commands.
    if [[ ("$1" == "apt" || "$1" == "apt-get") && "$2" == "install" ]]; then
        should_log_packages=true
        package_manager_name="apt"
        # Extract package arguments after command and action.
        packages_to_log=("${@:3}")

    # Check if the command is for pacman/yay and contains the -S (Sync) flag.
    # Matches flags starting with '-' that contain 'S' (e.g., -S, -Sy, -Syu).
    elif [[ ("$1" == "pacman" || "$1" == "yay") && "$2" =~ ^- && "$2" =~ S ]]; then
        should_log_packages=true
        package_manager_name="$1" # Dynamically set to 'pacman' or 'yay'
        # Extract package arguments after command and action.
        packages_to_log=("${@:3}")
    fi

    # If it was an install command, proceed with logging.
    if [ "$should_log_packages" = true ]; then
        echo "--> Logging packages to $LOG_FILE"
        for package in "${packages_to_log[@]}"; do
            # Filter out arguments that start with '-', such as '-y' or '--force'.
            if [[ ! "$package" =~ ^- ]]; then
                # Log format: Timestamp | Package Manager | Package Name
                echo "$(date '+%Y-%m-%d %H:%M:%S') | $package_manager_name | $package" >>"$LOG_FILE"
            fi
        done
    fi

    # --- EXECUTION ---
    # Execute the original sudo command.
    command sudo "$@"
}

# --- LOGGER HELPER FOR PYTHON PACKAGES (pip / pip3) ---
_log_pip_packages() {
    local pm_name="$1"
    shift
    local LOG_FILE="$HOME/info/installed_packages.log"
    mkdir -p "$(dirname "$LOG_FILE")"

    local is_install=false
    local is_global=false
    local prev_arg=""
    local packages_to_log=()

    for arg in "$@"; do
        if [[ "$arg" == "install" ]]; then
            is_install=true
            continue
        fi

        # Check for flags indicating global or user-level installation.
        case "$arg" in
            --user|--break-system-packages|--system|--global)
                is_global=true
                continue
                ;;
            --root|--prefix|--target|-t)
                is_global=true
                prev_arg="$arg"
                continue
                ;;
            --root=*|--prefix=*|--target=*)
                is_global=true
                continue
                ;;
        esac

        # Skip values corresponding to options that take parameters.
        case "$prev_arg" in
            -r|-c|-t|--target|--prefix|--root|-i|--index-url|--extra-index-url|-f|--find-links|-b|--build|--src)
                prev_arg=""
                continue
                ;;
        esac

        case "$arg" in
            -r|-c|-i|--index-url|--extra-index-url|-f|--find-links|-b|--build|--src)
                prev_arg="$arg"
                continue
                ;;
        esac

        # Filter out flags, relative/absolute paths, requirements files, wheels, and archives.
        if [[ ! "$arg" =~ ^- && "$arg" != "." && "$arg" != *".txt"* && "$arg" != *"/"* && "$arg" != *".whl"* && "$arg" != *".tar.gz"* && "$arg" != *".tgz"* ]]; then
            packages_to_log+=("$arg")
        fi
    done

    # Only log if running an install command with global/user flags.
    if [[ "$is_install" = true && "$is_global" = true && ${#packages_to_log[@]} -gt 0 ]]; then
        echo "--> Logging $pm_name packages to $LOG_FILE"
        for package in "${packages_to_log[@]}"; do
            echo "$(date '+%Y-%m-%d %H:%M:%S') | $pm_name | $package" >>"$LOG_FILE"
        done
    fi
}

pip() {
    _log_pip_packages "pip" "$@"
    command pip "$@"
}

pip3() {
    _log_pip_packages "pip3" "$@"
    command pip3 "$@"
}

# --- LOGGER FOR NODE PACKAGES (npm) ---
_log_npm_packages() {
    local pm_name="npm"
    local LOG_FILE="$HOME/info/installed_packages.log"
    mkdir -p "$(dirname "$LOG_FILE")"

    local is_install=false
    local is_global=false
    local prev_arg=""
    local packages_to_log=()

    for arg in "$@"; do
        case "$arg" in
            install|i|add|isntall)
                is_install=true
                continue
                ;;
            -g|--global|--location=global|-g=true)
                is_global=true
                continue
                ;;
            --location)
                prev_arg="--location"
                continue
                ;;
            --prefix|--registry|--tag|--scope)
                prev_arg="$arg"
                continue
                ;;
        esac

        if [[ "$prev_arg" == "--location" ]]; then
            if [[ "$arg" == "global" ]]; then
                is_global=true
            fi
            prev_arg=""
            continue
        elif [[ -n "$prev_arg" ]]; then
            prev_arg=""
            continue
        fi

        # Filter out flags, paths, urls, archives, json configs, and txt files.
        if [[ ! "$arg" =~ ^- && "$arg" != "." && "$arg" != ".." && ! "$arg" =~ ^(\./|\.\./|/) && "$arg" != *"://"* && "$arg" != *"git+"* && "$arg" != *".tgz"* && "$arg" != *".tar.gz"* && "$arg" != *".json"* && "$arg" != *".txt"* ]]; then
            packages_to_log+=("$arg")
        fi
    done

    # Only log if running an install command with global flags.
    if [[ "$is_install" = true && "$is_global" = true && ${#packages_to_log[@]} -gt 0 ]]; then
        echo "--> Logging npm packages to $LOG_FILE"
        for package in "${packages_to_log[@]}"; do
            echo "$(date '+%Y-%m-%d %H:%M:%S') | $pm_name | $package" >>"$LOG_FILE"
        done
    fi
}

npm() {
    _log_npm_packages "$@"
    command npm "$@"
}

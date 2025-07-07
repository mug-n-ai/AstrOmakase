#!/bin/bash
set -euo pipefail

# Destination directory for the AppImage
APP_DIR="$HOME/Applications"
mkdir -p "$APP_DIR" || { print_error "Failed to create $APP_DIR"; exit 1; }

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing scrcpy..."

# Function to install scrcpy dependencies
install_scrcpy_dependencies() {
    print_info "Installing scrcpy dependencies..."
    local dependencies=(
        "ffmpeg"
        "libsdl2-2.0-0"
        "adb"
        "wget"
        "gcc"
        "git"
        "pkg-config"
        "meson"
        "ninja-build"
        "libsdl2-dev"
        "libavcodec-dev"
        "libavdevice-dev"
        "libavformat-dev"
        "libavutil-dev"
        "libswresample-dev"
        "libusb-1.0-0"
        "libusb-1.0-0-dev"
    )

    for dep in "${dependencies[@]}"; do
        apt_install "$dep" || { print_error "Failed to install dependency: $dep"; return 1; }
    done
    print_success "scrcpy dependencies installed successfully."
    return 0
}

# Function to clone scrcpy repository
clone_scrcpy_repo() {
    local scrcpy_repo_dir="$APP_DIR/scrcpy"
    print_info "Checking scrcpy repository..."

    if [ -d "$scrcpy_repo_dir" ]; then
        if [ "$(ls -A "$scrcpy_repo_dir")" ]; then
            print_success "scrcpy repository already cloned and not empty. Skipping cloning."
            return 0
        else
            print_info "scrcpy directory exists but is empty. Removing and re-cloning."
            if rm -rf "$scrcpy_repo_dir"; then
                print_success "Empty scrcpy directory removed."
            else
                print_error "Failed to remove empty scrcpy directory."
                return 1
            fi
        fi
    fi

    print_info "Cloning scrcpy repository..."
    if git clone https://github.com/Genymobile/scrcpy "$scrcpy_repo_dir"; then
        print_success "scrcpy repository cloned successfully."
    else
        print_error "Failed to clone scrcpy repository."
        return 1
    fi
    return 0
}

# Function to run scrcpy install script
run_scrcpy_install_script() {
    local scrcpy_repo_dir="$APP_DIR/scrcpy"
    print_info "Running scrcpy installation script..."
    if [ ! -d "$scrcpy_repo_dir" ]; then
        print_error "scrcpy repository directory not found: $scrcpy_repo_dir."
        return 1
    fi

    (cd "$scrcpy_repo_dir" || { print_error "Failed to change directory to $scrcpy_repo_dir."; return 1; }
    # The install_release.sh script might not be idempotent, so we rely on the initial command_exists check.
    # If we reach here, it means scrcpy was not found, so we proceed with its installation script.
    if bash install_release.sh; then
        print_success "scrcpy installation script executed successfully."
    else
        print_error "Failed to execute scrcpy installation script."
        return 1
    fi
    )
    return 0
}

# Main execution flow
if command_exists scrcpy; then
    print_success "scrcpy is already installed. Skipping full installation process."
else
    print_info "scrcpy not found. Proceeding with installation."
    install_scrcpy_dependencies || exit 1
    clone_scrcpy_repo || exit 1
    run_scrcpy_install_script || exit 1
fi

print_success "scrcpy setup completed successfully."

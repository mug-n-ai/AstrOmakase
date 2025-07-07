#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Franz..."

if command_exists franz; then
    print_success "Franz is already installed. Skipping installation."
    exit 0
fi

print_info "Franz not found. Proceeding with installation."

print_info "Installing dependencies..."
apt_install "libx11-dev" || exit 1
apt_install "libxext-dev" || exit 1
apt_install "libxss-dev" || exit 1
apt_install "libxkbfile-dev" || exit 1
print_success "Dependencies installed successfully."

print_info "Fetching the latest Franz release download link..."
LATEST_FRANZ_URL=$(curl -s https://api.github.com/repos/meetfranz/franz/releases/latest | grep "browser_download_url.*amd64.deb" | cut -d '"' -f 4)
if [ -z "$LATEST_FRANZ_URL" ]; then
    print_error "Unable to fetch the latest Franz release download link. Exiting."
    exit 1
fi
print_success "Latest Franz release download link fetched successfully."

local franz_deb="/tmp/franz.deb"

print_info "Downloading Franz..."
if [ -f "$franz_deb" ]; then
    print_success "Franz .deb already exists. Skipping download."
else
    if ! wget -O "$franz_deb" "$LATEST_FRANZ_URL"; then
        print_error "Failed to download Franz. Exiting."
        exit 1
    fi
    print_success "Franz downloaded successfully."
fi

print_info "Installing Franz .deb package..."
if sudo dpkg -i "$franz_deb"; then
    print_success "Franz .deb package installed successfully."
else
    print_error "Failed to install Franz .deb package. Attempting to fix broken dependencies..."
    if sudo apt --fix-broken install -y; then
        print_success "Fixed broken dependencies. Retrying Franz .deb package installation..."
        if sudo dpkg -i "$franz_deb"; then
            print_success "Franz .deb package installed successfully after fixing dependencies."
        else
            print_error "Failed to install Franz .deb package even after fixing dependencies."
            exit 1
        fi
    else
        print_error "Failed to fix broken dependencies. Franz installation failed."
        exit 1
    fi
fi

print_info "Cleaning up temporary files..."
if rm "$franz_deb"; then
    print_success "Temporary files removed successfully."
else
    print_error "Failed to remove temporary files."
fi

print_success "Franz installation script completed successfully."

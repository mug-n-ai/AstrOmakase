#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Zoom..."

print_info "Checking if Zoom is already installed..."
if command_exists zoom; then
    print_success "Zoom is already installed. Skipping installation."
else
    print_info "Zoom not found. Proceeding with installation."

    local zoom_deb="/tmp/zoom.deb"
    local zoom_url="https://zoom.us/client/latest/zoom_amd64.deb"

    print_info "Downloading Zoom from $zoom_url..."
    if wget -O "$zoom_deb" "$zoom_url"; then
        print_success "Zoom downloaded successfully."
    else
        print_error "Failed to download Zoom. Exiting."
        exit 1
    fi

    print_info "Installing Zoom .deb package..."
    if sudo dpkg -i "$zoom_deb"; then
        print_success "Zoom .deb package installed successfully."
    else
        print_error "Failed to install Zoom .deb package. Attempting to fix broken dependencies..."
        if sudo apt --fix-broken install -y; then
            print_success "Fixed broken dependencies. Retrying Zoom .deb package installation..."
            if sudo dpkg -i "$zoom_deb"; then
                print_success "Zoom .deb package installed successfully after fixing dependencies."
            else
                print_error "Failed to install Zoom .deb package even after fixing dependencies."
                exit 1
            fi
        else
            print_error "Failed to fix broken dependencies. Zoom installation failed."
            exit 1
        fi
    fi

    print_info "Removing temporary files..."
    if rm "$zoom_deb"; then
        print_success "Temporary files removed successfully."
    else
        print_error "Failed to remove temporary files."
    fi
fi

print_success "Zoom setup completed successfully."

#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing PDFsam..."

print_info "Checking if PDFsam is already installed..."
if command_exists pdfsam; then
    print_success "PDFsam is already installed. Skipping installation."
else
    print_info "PDFsam not found. Proceeding with installation."

    local pdfsam_deb="/tmp/pdfsam.deb"
    local pdfsam_url="https://github.com/torakiki/pdfsam/releases/download/v5.2.3/pdfsam_5.2.3-1_amd64.deb"

    print_info "Downloading PDFsam .deb package from $pdfsam_url..."
    if wget -O "$pdfsam_deb" "$pdfsam_url"; then
        print_success "PDFsam .deb package downloaded successfully."
    else
        print_error "Failed to download PDFsam. Exiting."
        exit 1
    fi

    print_info "Installing PDFsam .deb package..."
    if sudo dpkg -i "$pdfsam_deb"; then
        print_success "PDFsam .deb package installed successfully."
    else
        print_error "Failed to install PDFsam .deb package. Attempting to fix broken dependencies..."
        if sudo apt --fix-broken install -y; then
            print_success "Fixed broken dependencies. Retrying PDFsam .deb package installation..."
            if sudo dpkg -i "$pdfsam_deb"; then
                print_success "PDFsam .deb package installed successfully after fixing dependencies."
            else
                print_error "Failed to install PDFsam .deb package even after fixing dependencies."
                exit 1
            fi
        else
            print_error "Failed to fix broken dependencies. PDFsam installation failed."
            exit 1
        fi
    fi

    print_info "Cleaning up temporary files..."
    if rm "$pdfsam_deb"; then
        print_success "Temporary files removed successfully."
    else
        print_error "Failed to remove temporary files."
    fi
fi

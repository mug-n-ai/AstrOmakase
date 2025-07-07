#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing PDFsam..."

echo "Checking if PDFsam is already installed..."
if command_exists pdfsam; then
    print_success "PDFsam is already installed. Exiting script."

else
    echo "Downloading PDFsam .deb package..."
    if ! wget -O /tmp/pdfsam.deb https://github.com/torakiki/pdfsam/releases/download/v5.2.3/pdfsam_5.2.3-1_amd64.deb; then
        print_error "Failed to download PDFsam. Exiting."
        exit 1
    fi
    print_success "PDFsam .deb package downloaded successfully."

    apt_install /tmp/pdfsam.deb

    echo "Cleaning up..."
    if ! rm /tmp/pdfsam.deb; then
        print_error "Failed to remove temporary files."
    else
        print_success "Removed temporary files."
    fi

fi

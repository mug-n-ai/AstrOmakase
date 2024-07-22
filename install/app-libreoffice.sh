#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Installing LibreOffice..."
sudo apt install -y libreoffice
if [ $? -ne 0 ]; then
    print_error "Failed to install LibreOffice. Exiting."
    exit 1
fi
print_success "LibreOffice installed successfully."

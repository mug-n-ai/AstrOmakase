#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Installing kdiff3..."
sudo apt install -y kdiff3
if [ $? -ne 0 ]; then
    print_error "Failed to install kdiff3. Exiting."
    exit 1
fi
print_success "kdiff3 installed successfully."

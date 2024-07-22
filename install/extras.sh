#!/bin/bash


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"


echo "Installing ubuntu-restricted-extras..."
sudo apt install -y ubuntu-restricted-extras
if [ $? -ne 0 ]; then
    print_error "Failed to install ubuntu-restricted-extras. Exiting."
    exit 1
fi
print_success "ubuntu-restricted-extras installed successfully."

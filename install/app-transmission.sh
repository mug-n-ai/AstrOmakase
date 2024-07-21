#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Installing Transmission..."
sudo apt install -y transmission
if [ $? -ne 0 ]; then
    print_error "Failed to install Transmission. Exiting."
    exit 1
fi
print_success "Transmission installed successfully."

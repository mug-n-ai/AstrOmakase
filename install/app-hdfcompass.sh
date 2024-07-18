#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Installing hdf-compass..."
sudo apt install -y hdf-compass
if [ $? -ne 0 ]; then
    print_error "Failed to install hdf-compass. Exiting."
    exit 1
fi
print_success "hdf-compass installed successfully."

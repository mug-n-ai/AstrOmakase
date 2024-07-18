#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"


echo "Installing sync tools..."
sudo apt install -y rclone rsync
if [ $? -ne 0 ]; then
    print_error "Failed to install sync tools. Exiting."
    exit 1
fi
print_success "sync tools installed successfully."

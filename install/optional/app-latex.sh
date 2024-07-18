#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"


echo "Installing texstudio..."
sudo apt install -y texstudio
if [ $? -ne 0 ]; then
    print_error "Failed to install texstudio. Exiting."
    exit 1
fi
print_success "texstudio installed successfully."

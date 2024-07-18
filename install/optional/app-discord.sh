#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"


echo "Installing Discord via Snap..."
sudo snap install discord
if [ $? -ne 0 ]; then
    print_error "Failed to install Discord via Snap. Exiting."
    exit 1
fi
print_success "Discord installed successfully via Snap."

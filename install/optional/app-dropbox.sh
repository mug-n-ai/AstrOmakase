#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"

echo "Checking if Dropbox is already installed..."
if dpkg -l | grep -q nautilus-dropbox; then
    print_success "Dropbox is already installed. Exiting script."
else

	apt_install nauilus-dropbox

fi

echo "Dropbox setup completed successfully."

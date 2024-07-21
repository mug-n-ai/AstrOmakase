#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"

echo "Checking if Dropbox is already installed..."
if dpkg -l | grep -q nautilus-dropbox; then
    print_success "Dropbox is already installed. Exiting script."
else
	echo "Installing Dropbox..."
	sudo apt install -y nautilus-dropbox >/dev/null
	if [ $? -ne 0 ]; then
	    print_error "Failed to install Dropbox. Exiting."
	    exit 1
	fi
	print_success "Dropbox installed successfully."

fi

echo "Installing dbxfs..."
pip3 install dbxfs
if [ $? -ne 0 ]; then
    print_error "Failed to install dbxfs. Exiting."
    exit 1
fi
print_success "dbxfs installed successfully."

echo "Dropbox setup completed successfully."

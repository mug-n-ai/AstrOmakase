#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Zoom..."

echo "Checking if Zoom is already installed..."
if command_exists zoom; then
    print_success "Zoom is already installed. Exiting script."
else
	echo "Downloading Zoom..."
	wget -O /tmp/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
	if [ $? -ne 0 ]; then
	    print_error "Failed to download Zoom. Exiting."
	    exit 1
	fi
	print_success "Zoom downloaded successfully."

	 apt_install /tmp/zoom.deb

	echo "Removing temporary files..."
	rm /tmp/zoom.deb
	if [ $? -ne 0 ]; then
	    print_error "Failed to remove temporary files."
	else
	    print_success "Temporary files removed successfully."
	fi

fi


echo "Zoom setup completed successfully."

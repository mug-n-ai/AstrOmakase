#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing NordVPN..."

echo "Checking if NordVPN is installed..."
if command_exists nordvpn; then
    print_success "NordVPN is already installed. Skipping."
else
	echo "Downloading NordVPN installation script..."
	wget -qO /tmp/nordvpn-install.sh https://downloads.nordcdn.com/apps/linux/install.sh
	if [ $? -ne 0 ]; then
	    print_error "Failed to download NordVPN installation script. Exiting."
	    exit 1
	fi


	echo "Running NordVPN installation script..."
	sh /tmp/nordvpn-install.sh
	if [ $? -ne 0 ]; then
	    print_error "Failed to install NordVPN. Exiting."
	    exit 1
	fi

	# Remove the downloaded installation script
	echo "Cleaning up..."
	rm /tmp/nordvpn-install.sh
	if [ $? -ne 0 ]; then
	    print_error "Failed to remove temporary files."
	else
	    print_success "Removed temporary files."
	fi
fi




print_success "NordVPN installation completed successfully."

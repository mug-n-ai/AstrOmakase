#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Checking if Visual Studio Code is already installed..."
if command_exists code; then
    print_success "Visual Studio Code is already installed. Exiting script."
else

	echo "Downloading Visual Studio Code..."
	cd /tmp
	wget -O code.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
	if [ $? -ne 0 ]; then
	    print_error "Failed to download Visual Studio Code. Exiting."
	    exit 1
	fi
	print_success "Visual Studio Code downloaded successfully."

	apt_install ./code.deb

	echo "Removing temporary files..."
	rm code.deb
	if [ $? -ne 0 ]; then
	    print_error "Failed to remove temporary files."
	else
	    print_success "Temporary files removed successfully."
	fi
	cd -

	echo "Installing default supported themes..."
	code --install-extension enkia.tokyo-night
	if [ $? -ne 0 ]; then
	    print_error "Failed to install Tokyo Night theme for Visual Studio Code. Exiting."
	    exit 1
	fi
	print_success "Tokyo Night theme installed successfully."
fi



echo "Visual Studio Code setup completed successfully."

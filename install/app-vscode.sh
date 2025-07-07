#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Visual Studio Code..."

echo "Checking if Visual Studio Code is already installed..."
if command_exists code; then
    print_success "Visual Studio Code is already installed. Exiting script."
else

	echo "Downloading Visual Studio Code..."
	(cd /tmp || exit
	wget -O code.deb 'https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64'
	print_success "Visual Studio Code downloaded successfully."

	apt_install ./code.deb

	rm code.deb
	print_success "Temporary files removed successfully.")

	echo "Installing pre configured settings..."
	mkdir -p ~/.config/Code/User
	cp ~/.local/share/astromakase/configs/vscode.json ~/.config/Code/User/settings.json


	echo "Installing default supported themes..."
	if ! code --install-extension enkia.tokyo-night; then
	    print_error "Failed to install Tokyo Night theme for Visual Studio Code. Exiting."
	    exit 1
	fi
	print_success "Tokyo Night theme installed successfully."
fi



echo "Visual Studio Code setup completed successfully."

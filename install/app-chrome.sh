#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Google Chrome..."

echo "Checking if Google Chrome is already installed..."
if command_exists google-chrome; then
    print_success "Google Chrome is already installed. Exiting script."

else
	echo "Downloading Google Chrome..."
	wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
	if [ $? -ne 0 ]; then
	    print_error "Failed to download Google Chrome. Exiting."
	    exit 1
	fi
	print_success "Google Chrome downloaded successfully."

	apt_install /tmp/chrome.deb

	echo "Removing temporary files..."
	rm /tmp/chrome.deb
	if [ $? -ne 0 ]; then
	    print_error "Failed to remove temporary files."
	else
	    print_success "Temporary files removed successfully."
	fi

	echo "Setting Google Chrome as the default web browser..."
	xdg-settings set default-web-browser google-chrome.desktop
	if [ $? -ne 0 ]; then
	    print_error "Failed to set Google Chrome as the default web browser. Exiting."
	    exit 1
	fi
	print_success "Google Chrome set as the default web browser."

fi

sudo apt-get install gnome-browser-connector

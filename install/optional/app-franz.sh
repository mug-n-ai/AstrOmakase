#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Franz..."

echo "Checking if Franz is installed..."
if command_exists franz; then
    print_success "Franz is already installed. Skipping."
else
	echo "Installing dependencies..."
	sudo apt install -y libx11-dev libxext-dev libxss-dev libxkbfile-dev
	if [ $? -ne 0 ]; then
	    print_error "Failed to install dependencies. Exiting."
	    exit 1
	fi

	echo "Fetching the latest Franz release download link..."
	LATEST_FRANZ_URL=$(curl -s https://api.github.com/repos/meetfranz/franz/releases/latest | grep "browser_download_url.*amd64.deb" | cut -d '"' -f 4)
	if [ -z "$LATEST_FRANZ_URL" ]; then
	    print_error "Unable to fetch the latest Franz release download link. Exiting."
	    exit 1
	fi

	echo "Downloading Franz..."
	wget -O /tmp/franz.deb "$LATEST_FRANZ_URL"
	if [ $? -ne 0 ]; then
	    print_error "Failed to download Franz. Exiting."
	    exit 1
	fi

	apt_install /tmp/franz.deb

	# Remove the downloaded .deb file
	echo "Cleaning up..."
	rm /tmp/franz.deb
	if [ $? -ne 0 ]; then
	    print_error "Failed to remove temporary files."
	else
	    print_success "Removed temporary files."
	fi

fi


print_success "Franz installation script completed successfully."

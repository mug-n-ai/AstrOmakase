#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Checking if OBS Studio is already installed..."
if dpkg -l | grep -q obs-studio; then
    print_success "OBS Studio is already installed. Exiting script."

else
	echo "Installing OBS Studio..."
	sudo apt install -y obs-studio
	if [ $? -ne 0 ]; then
	    print_error "Failed to install OBS Studio. Exiting."
	    exit 1
	fi
	print_success "OBS Studio installed successfully."

fi


echo "OBS Studio setup completed successfully."

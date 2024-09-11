#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Checking if Flameshot is already installed..."
if dpkg -l | grep -q flameshot; then
    print_success "Flameshot is already installed. Exiting script."

else
	apt_install flameshot

fi


echo "Flameshot setup completed successfully."

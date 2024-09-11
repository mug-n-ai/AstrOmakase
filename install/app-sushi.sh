#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Checking if Sushi is already installed..."
if dpkg -l | grep -q sushi; then
    print_success "Sushi is already installed. Exiting script."

else
	apt_install gnome-sushi

fi


echo "Sushi setup completed successfully."

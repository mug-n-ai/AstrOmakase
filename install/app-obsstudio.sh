#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Checking if OBS Studio is already installed..."
if dpkg -l | grep -q obs-studio; then
    print_success "OBS Studio is already installed. Exiting script."

else
	apt_install obs-studio

fi


echo "OBS Studio setup completed successfully."

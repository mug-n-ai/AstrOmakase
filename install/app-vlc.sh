#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

if command_exists vlc; then
    print_success "VLC is already installed. Exiting script."
else
	apt_install vlc

fi

print_success "VLC installed successfully."

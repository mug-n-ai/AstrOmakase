#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"


# echo "Checking if gdm-settings is already installed..."
# if command_exists gdm-settings; then
#     print_success "gdm-settings is already installed. Exiting script."
# else
#     echo "installing dependencies..."
#     apt_install libglib2.0-dev-bin
#     echo "Installing gdm-settings..."
#     apt_install gdm-settings
#     print_success "gdm-settings installed successfully."
# fi

install_package "gdm-settings" "gdm-settings" "gdm-settings" "apt" "libglib2.0-dev-bin"

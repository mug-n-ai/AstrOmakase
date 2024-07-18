#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"



echo "Installing Upscayl via Flatpak..."
flatpak install flathub org.upscayl.Upscayl
if [ $? -ne 0 ]; then
    print_error "Failed to install Upscayl via Flatpak. Exiting."
    exit 1
fi

print_success "Upscayl installed successfully via Flatpak."

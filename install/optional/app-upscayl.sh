#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Upscayl via Flatpak..."

echo "Installing Upscayl via Flatpak..."
if ! flatpak install flathub org.upscayl.Upscayl; then
    print_error "Failed to install Upscayl via Flatpak. Exiting."
    exit 1
fi

print_success "Upscayl installed successfully via Flatpak."

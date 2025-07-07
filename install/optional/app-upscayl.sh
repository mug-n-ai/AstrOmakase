#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Upscayl via Flatpak..."

if flatpak list | grep -q "org.upscayl.Upscayl"; then
    print_success "Upscayl is already installed via Flatpak. Skipping installation."
else
    print_info "Upscayl not found via Flatpak. Proceeding with installation."
    print_info "Installing Upscayl via Flatpak..."
    if flatpak install flathub org.upscayl.Upscayl -y; then
        print_success "Upscayl installed successfully via Flatpak."
    else
        print_error "Failed to install Upscayl via Flatpak. Exiting."
        exit 1
    fi
fi

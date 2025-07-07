#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing NordVPN..."

if command_exists nordvpn; then
    print_success "NordVPN is already installed. Skipping installation."
    exit 0
fi

print_info "NordVPN not found. Proceeding with installation."

local nordvpn_install_script="/tmp/nordvpn-install.sh"
local nordvpn_script_url="https://downloads.nordcdn.com/apps/linux/install.sh"

print_info "Downloading NordVPN installation script from $nordvpn_script_url..."
if [ -f "$nordvpn_install_script" ]; then
    print_success "NordVPN installation script already exists. Skipping download."
else
    if ! wget -qO "$nordvpn_install_script" "$nordvpn_script_url"; then
        print_error "Failed to download NordVPN installation script. Exiting."
        exit 1
    fi
    print_success "NordVPN installation script downloaded successfully."
fi

print_info "Running NordVPN installation script..."
if sh "$nordvpn_install_script"; then
    print_success "NordVPN installed successfully."
else
    print_error "Failed to install NordVPN. Please check the output above for details."
    exit 1
fi

print_info "Removing temporary files..."
if rm "$nordvpn_install_script"; then
    print_success "Temporary files removed successfully."
else
    print_error "Failed to remove temporary files."
fi

print_success "NordVPN installation completed successfully."

#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Zed..."

if command_exists zed; then
    print_success "Zed is already installed. Skipping installation."
else
    print_info "Zed not found. Proceeding with installation."
    print_info "Running Zed installation script..."
    if curl https://zed.dev/install.sh | sh; then
        print_success "Zed installed successfully."
    else
        print_error "Failed to install Zed. Please check the output above for details."
        exit 1
    fi
fi

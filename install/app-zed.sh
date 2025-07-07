#!/bin/bash


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Zed..."

if command_exists zed; then
    print_success "Zed is already installed. Exiting script."
else
    echo "Instaling Zed package..."
    if ! curl https://zed.dev/install.sh | sh; then
        print_error "Failed to install Zed. Exiting."
        exit 1
    fi
fi

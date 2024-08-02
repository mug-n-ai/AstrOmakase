#!/bin/bash


SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"


if command_exists zed; then
    print_success "Zed is already installed. Exiting script."
else
    echo "Instaling Zed package..."
    curl https://zed.dev/install.sh | sh
    if [ $? -ne 0 ]; then
        print_error "Failed to install Zed. Exiting."
        exit 1
    fi
fi

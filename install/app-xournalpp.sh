#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Checking if Xournal++ is already installed..."
if command_exists xournalpp; then
    print_success "Xournal++ is already installed. Exiting script."

else
    echo "Installing Xournal++..."
    sudo apt install -y xournalpp
    if [ $? -ne 0 ]; then
        print_error "Failed to install Xournal++. Exiting."
        exit 1
    fi
    print_success "Xournal++ installed successfully."
fi

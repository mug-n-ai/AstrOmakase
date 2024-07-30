#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Checking if Xournal++ is already installed..."
if command_exists xournalpp; then
    print_success "Xournal++ is already installed. Exiting script."

else
    apt_install -y xournalpp
fi

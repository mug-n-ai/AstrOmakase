#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"


install_package "SAO DS9" "ds9" "saods9" "apt" "None"

install_package "FITSVerify" "fitsverify" "ftools-fv" "apt" "None"

install_package "FTOOLS FV" "ftools-fv" "ftools-fv" "apt" "None"

install_package "Stellarium" "stellarium" "stellarium" "apt" "None"

echo "Installing Zotero..."
if command_exists zotero; then
    print_success "Zotero is already installed. Skipping."
else
    curl -sL https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
    if [ $? -ne 0 ]; then
        print_error "Failed to install Zotero. Exiting."
        exit 1
    fi
    print_success "Zotero installed successfully."
fi

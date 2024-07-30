#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Installing SAO DS9, FITSVerify, and FTOOLS FV..."

apt_install saods9
apt_install fitsverify
apt_install ftools-fv


echo "Installing Stellarium..."
if command_exists stellarium; then
    print_success "Stellarium is already installed. Skipping."
else
    apt_install stellarium
fi

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

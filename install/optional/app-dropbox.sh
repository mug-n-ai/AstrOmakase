#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Dropbox..."

install_package "Dropbox" "nautilus-dropbox" "nautilus-dropbox" "apt" "None"

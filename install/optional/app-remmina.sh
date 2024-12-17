#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Remmina..."

install_package "remmina" "remmina" "remmina" "apt" "None"

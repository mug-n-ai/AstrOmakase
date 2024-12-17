#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing GIMP..."

install_package "gimp" "gimp" "gimp" "apt" "None"

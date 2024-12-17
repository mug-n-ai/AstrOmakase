#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing KDiff3..."

install_package "kdiff3" "kdiff3" "kdiff3" "apt" "None"

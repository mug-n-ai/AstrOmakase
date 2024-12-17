#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Sync Tools..."

install_package "rclone" "rclone" "rclone" "apt" "None"

install_package "rsync" "rsync" "rsync" "apt" "None"


#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

install_package "rclone" "rclone" "rclone" "apt" "None"

install_package "rsync" "rsync" "rsync" "apt" "None"


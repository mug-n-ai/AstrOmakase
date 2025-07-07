#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Sync Tools..."

local dependencies_rclone=()
install_package "rclone" "rclone" "rclone" "apt" "dependencies_rclone"

local dependencies_rsync=()
install_package "rsync" "rsync" "rsync" "apt" "dependencies_rsync"


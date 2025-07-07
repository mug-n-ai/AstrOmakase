#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing VLC..."

local dependencies_vlc=()
install_package "vlc" "vlc" "vlc" "apt" "dependencies_vlc"

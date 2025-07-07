#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Flameshot..."

local dependencies_flameshot=()
install_package "flameshot" "flameshot" "flameshot" "apt" "dependencies_flameshot"

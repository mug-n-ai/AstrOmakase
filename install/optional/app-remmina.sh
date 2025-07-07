#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Remmina..."

local dependencies_remmina=()
install_package "remmina" "remmina" "remmina" "apt" "dependencies_remmina"

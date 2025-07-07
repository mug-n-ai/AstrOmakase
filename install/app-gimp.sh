#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing GIMP..."

local dependencies_gimp=()
install_package "gimp" "gimp" "gimp" "apt" "dependencies_gimp"

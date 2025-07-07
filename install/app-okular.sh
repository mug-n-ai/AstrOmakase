#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Okular..."

local dependencies_okular=()
install_package "okular" "okular" "okular" "snap" "dependencies_okular"

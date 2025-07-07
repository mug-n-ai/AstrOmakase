#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing KDiff3..."

local dependencies_kdiff3=()
install_package "kdiff3" "kdiff3" "kdiff3" "apt" "dependencies_kdiff3"

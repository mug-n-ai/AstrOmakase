#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing LaTeX..."

local dependencies_latex=()
install_package "texstudio" "texstudio" "texstudio" "apt" "dependencies_latex"

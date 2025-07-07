#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing HDFCompass..."

local dependencies_hdfcompass=()
install_package "HDFCompass" "HDFCompass" "hdf-compass" "apt" "dependencies_hdfcompass"

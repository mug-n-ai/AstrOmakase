#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Krita..."

local dependencies_krita=()
install_package "krita" "krita" "krita" "apt" "dependencies_krita"

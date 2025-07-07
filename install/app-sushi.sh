#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Sushi..."

local dependencies_sushi=()
install_package "sushi" "sushi" "gnome-sushi" "apt" "dependencies_sushi"

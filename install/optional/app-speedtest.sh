#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Speedtest..."

local dependencies_speedtest=()
install_package "speedtest-cli" "speedtest-cli" "speedtest-cli" "apt" "dependencies_speedtest"

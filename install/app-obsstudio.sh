#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing OBS Studio..."

local dependencies_obs_studio=()
install_package "OBS Studio" "obs-studio" "obs-studio" "apt" "dependencies_obs_studio"

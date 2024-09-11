#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

install_package "kdiff3" "kdiff3" "kdiff3" "apt" "None"
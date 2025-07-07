#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Xournal++..."

local dependencies_xournalpp=()
install_package "Xournal++" "xournalpp" "xournalpp" "apt" "dependencies_xournalpp"

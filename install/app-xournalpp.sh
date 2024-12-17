#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Xournal++..."

install_package "Xournal++" "xournalpp" "xournalpp" "apt" "None"

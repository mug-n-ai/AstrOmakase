#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Gemini CLI..."

if command -v npm &> /dev/null
then
    npm install -g @google/gemini-cli
    print_success "Gemini CLI installed!"
else
    print_error "npm is not installed. Please install Node.js and npm first."
fi

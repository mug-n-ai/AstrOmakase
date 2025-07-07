#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Gemini CLI..."

if command_exists gemini; then
    print_success "Gemini CLI is already installed. Skipping installation."
    exit 0
fi

print_info "Gemini CLI not found. Proceeding with installation."

if command_exists npm; then
    print_info "npm is installed. Installing Gemini CLI globally..."
    if npm install -g @google/gemini-cli; then
        print_success "Gemini CLI installed successfully."
    else
        print_error "Failed to install Gemini CLI. Please check npm output for details."
        exit 1
    fi
else
    print_error "npm is not installed. Please install Node.js and npm first to install Gemini CLI."
    exit 1
fi

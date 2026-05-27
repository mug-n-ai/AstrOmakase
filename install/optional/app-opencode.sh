#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing OpenCode..."

OPENCODE_BIN_DIR="$HOME/.opencode/bin"
OPENCODE_BIN="$OPENCODE_BIN_DIR/opencode"

if command_exists opencode || [ -x "$OPENCODE_BIN" ]; then
    print_success "OpenCode is already installed. Skipping OpenCode binary installation."
else
    print_info "OpenCode not found. Installing via the official installer..."
    if curl -fsSL https://opencode.ai/install | bash; then
        print_success "OpenCode installed successfully."
    else
        print_error "Failed to install OpenCode. Please check the installer output for details."
        exit 1
    fi
fi

if [ -d "$OPENCODE_BIN_DIR" ]; then
    export PATH="$OPENCODE_BIN_DIR:$PATH"
fi

if [ -x "$OPENCODE_BIN" ] && ! grep -qF "$OPENCODE_BIN_DIR" "$HOME/.bashrc"; then
    print_info "Adding OpenCode to PATH in ~/.bashrc..."
    {
        echo ""
        echo "# opencode"
        echo "export PATH=\"$OPENCODE_BIN_DIR:\$PATH\""
    } >> "$HOME/.bashrc"
fi

if command_exists npm; then
    print_info "Installing oh-my-openagent globally with npm..."
    if npm install -g oh-my-openagent; then
        print_success "oh-my-openagent installed globally."
    else
        print_error "Failed to install oh-my-openagent globally. Please check npm output for details."
        exit 1
    fi

    print_info "Installing and enabling oh-my-openagent for OpenCode..."
    if opencode plugin oh-my-openagent --global; then
        print_success "oh-my-openagent enabled for OpenCode."
    else
        print_error "Failed to install oh-my-openagent for OpenCode. Please check OpenCode output for details."
        exit 1
    fi
else
    print_error "npm is not installed. Please install Node.js and npm first to install oh-my-openagent."
    exit 1
fi

print_success "OpenCode and oh-my-openagent setup completed successfully."

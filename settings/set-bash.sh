#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting up bash..."

# Add the path to the .bashrc file only if it does not already exist
local init_source_line="source \"$HOME/.local/share/astromakase/settings/config/bash/init\""
if ! grep -qF "$init_source_line" "$HOME/.bashrc"; then
    print_info "Adding init source line to ~/.bashrc..."
    echo "" >> "$HOME/.bashrc" # Add a newline for separation
    echo "$init_source_line" >> "$HOME/.bashrc"
    print_success "init source line added to ~/.bashrc."
else
    print_success "init source line already exists in ~/.bashrc. Skipping."
fi

# Enable coloured terminal prompts idempotently
local color_prompt_lines="force_color_prompt=yes\ncolor_prompt=yes"
if ! grep -qF "force_color_prompt=yes" "$HOME/.bashrc"; then
    print_info "Adding color prompt settings to ~/.bashrc..."
    echo "" >> "$HOME/.bashrc" # Add a newline for separation
    echo -e "$color_prompt_lines" >> "$HOME/.bashrc"
    print_success "Color prompt settings added to ~/.bashrc."
else
    print_success "Color prompt settings already exist in ~/.bashrc. Skipping."
fi

# Handle .inputrc file
local source_inputrc="$SCRIPT_DIR/config/bash/inputrc"
local target_inputrc="$HOME/.inputrc"

print_info "Setting up .inputrc..."
if [ -f "$source_inputrc" ]; then
    if [ -f "$target_inputrc" ]; then
        if cmp -s "$source_inputrc" "$target_inputrc"; then
            print_success ".inputrc is already up-to-date. Skipping copy."
        else
            print_info "Backing up existing .inputrc to $target_inputrc.bak..."
            if mv "$target_inputrc" "$target_inputrc.bak"; then
                print_success "Existing .inputrc backed up."
            else
                print_error "Failed to backup existing .inputrc. Skipping .inputrc update."
                exit 1
            fi

            print_info "Copying new .inputrc to $target_inputrc..."
            if cp "$source_inputrc" "$target_inputrc"; then
                print_success ".inputrc updated successfully."
            else
                print_error "Failed to copy new .inputrc."
                exit 1
            fi
        fi
    else
        print_info "Copying .inputrc to $target_inputrc (no existing file found)..."
        if cp "$source_inputrc" "$target_inputrc"; then
            print_success ".inputrc copied successfully."
        else
            print_error "Failed to copy .inputrc."
            exit 1
        fi
    fi
else
    print_error "Source .inputrc file not found at $source_inputrc. Skipping .inputrc setup."
    exit 1
fi

print_success "Bash setup complete."

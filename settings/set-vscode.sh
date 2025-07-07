#!/bin/bash
set -euo pipefail

# This settings are inspired by the Omakub project. Please visit the [Omakub project](https://github.com/basecamp/omakub) 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting VSCode theme..."

VSC_THEME="Tokyo Night"
VSC_EXTENSION="enkia.tokyo-night"
VSCODE_SETTINGS_FILE="$HOME/.config/Code/User/settings.json"

# Install VS Code extension idempotently
print_info "Checking if VS Code extension '$VSC_EXTENSION' is installed..."
if command_exists code; then
    if code --list-extensions | grep -q "^$VSC_EXTENSION$"; then
        print_success "VS Code extension '$VSC_EXTENSION' is already installed. Skipping installation."
    else
        print_info "Installing VS Code extension '$VSC_EXTENSION'..."
        if code --install-extension "$VSC_EXTENSION"; then
            print_success "VS Code extension '$VSC_EXTENSION' installed successfully."
        else
            print_error "Failed to install VS Code extension '$VSC_EXTENSION'."
            exit 1
        fi
    fi
else
    print_error "VS Code command 'code' not found. Skipping extension installation."
fi

# Set VS Code theme idempotently
print_info "Setting VS Code theme to '$VSC_THEME'..."
if [ -f "$VSCODE_SETTINGS_FILE" ]; then
    if grep -q "\"workbench.colorTheme\": \"$VSC_THEME\"" "$VSCODE_SETTINGS_FILE"; then
        print_success "VS Code theme is already set to '$VSC_THEME'. Skipping."
    else
        print_info "Updating VS Code theme in $VSCODE_SETTINGS_FILE..."
        # Use sed to replace the theme, or add it if not present
        if sed -i "s/\(\"workbench.colorTheme\": \)\".*\"/\1\"$VSC_THEME\"/g" "$VSCODE_SETTINGS_FILE"; then
            print_success "VS Code theme updated to '$VSC_THEME'."
        else
            # If sed failed (e.g., theme not present), try adding it
            if ! grep -q "\"workbench.colorTheme\":" "$VSCODE_SETTINGS_FILE"; then
                print_info "'workbench.colorTheme' not found in settings.json. Adding it."
                # Add the theme setting to the end of the JSON object
                # This is a simplified approach; a more robust solution might use jq
                if sed -i '$s/}/, "workbench.colorTheme": "'$VSC_THEME'"}/' "$VSCODE_SETTINGS_FILE"; then
                    print_success "VS Code theme added to settings.json."
                else
                    print_error "Failed to add VS Code theme to settings.json."
                fi
            else
                print_error "Failed to set VS Code theme in $VSCODE_SETTINGS_FILE."
            fi
        fi
    fi
else
    print_error "VS Code settings file not found at $VSCODE_SETTINGS_FILE. Cannot set theme."
fi

print_success "VSCode theme setup complete."

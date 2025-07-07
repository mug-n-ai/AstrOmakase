#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Visual Studio Code..."

if command_exists code; then
    print_success "Visual Studio Code is already installed. Skipping main installation."
else
    print_info "Visual Studio Code not found. Proceeding with installation."

    local vscode_deb="/tmp/code.deb"
    local vscode_url="https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"

    print_info "Downloading Visual Studio Code..."
    if [ -f "$vscode_deb" ]; then
        print_success "Visual Studio Code .deb already exists. Skipping download."
    else
        if wget -O "$vscode_deb" "$vscode_url"; then
            print_success "Visual Studio Code downloaded successfully."
        else
            print_error "Failed to download Visual Studio Code. Exiting."
            exit 1
        fi
    fi

    print_info "Installing Visual Studio Code .deb package..."
    if sudo dpkg -i "$vscode_deb"; then
        print_success "Visual Studio Code .deb package installed successfully."
    else
        print_error "Failed to install Visual Studio Code .deb package. Attempting to fix broken dependencies..."
        if sudo apt --fix-broken install -y; then
            print_success "Fixed broken dependencies. Retrying Visual Studio Code .deb package installation..."
            if sudo dpkg -i "$vscode_deb"; then
                print_success "Visual Studio Code .deb package installed successfully after fixing dependencies."
            else
                print_error "Failed to install Visual Studio Code .deb package even after fixing dependencies."
                exit 1
            fi
        else
            print_error "Failed to fix broken dependencies. Visual Studio Code installation failed."
            exit 1
        fi
    fi

    print_info "Removing temporary files..."
    if rm "$vscode_deb"; then
        print_success "Temporary files removed successfully."
    else
        print_error "Failed to remove temporary files."
    fi
fi

print_info "Installing pre-configured settings..."
local vscode_config_dir="$HOME/.config/Code/User"
local vscode_settings_file="$vscode_config_dir/settings.json"
local astromakase_vscode_settings="$HOME/.local/share/astromakase/configs/vscode.json"

if [ ! -d "$vscode_config_dir" ]; then
    print_info "Creating VS Code user config directory: $vscode_config_dir"
    if mkdir -p "$vscode_config_dir"; then
        print_success "VS Code user config directory created."
    else
        print_error "Failed to create VS Code user config directory."
    fi
fi

if [ -f "$astromakase_vscode_settings" ]; then
    if [ -f "$vscode_settings_file" ] && cmp -s "$astromakase_vscode_settings" "$vscode_settings_file"; then
        print_success "VS Code settings already up-to-date. Skipping copy."
    else
        print_info "Copying VS Code settings from $astromakase_vscode_settings to $vscode_settings_file..."
        if cp "$astromakase_vscode_settings" "$vscode_settings_file"; then
            print_success "VS Code settings copied successfully."
        else
            print_error "Failed to copy VS Code settings."
        fi
    fi
else
    print_error "Astromakase VS Code settings file not found at $astromakase_vscode_settings. Skipping settings copy."
fi

print_info "Installing default supported themes..."
local theme_extension="enkia.tokyo-night"
if code --list-extensions | grep -q "^$theme_extension$"; then
    print_success "VS Code extension '$theme_extension' is already installed. Skipping installation."
else
    print_info "Installing VS Code extension '$theme_extension'..."
    if code --install-extension "$theme_extension"; then
        print_success "VS Code extension '$theme_extension' installed successfully."
    else
        print_error "Failed to install VS Code extension '$theme_extension'."
    fi
fi

print_success "Visual Studio Code setup completed successfully."

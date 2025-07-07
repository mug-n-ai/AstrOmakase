#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting up AstrOmakase launcher..."

local desktop_file_path="$HOME/.local/share/applications/AstrOmakase.desktop"
local astromakase_icon_path="$HOME/.local/share/astromakase/content/icon.png"
local astromakase_bin_path="$HOME/.local/share/astromakase/bin/astromakase"

# Create the AstrOmakase.desktop file idempotently
print_info "Checking AstrOmakase.desktop file..."
local desktop_entry_content="[Desktop Entry]\nVersion=1.0\nName=AstrOmakase\nComment=AstrOmakase launcher\nExec=astromakase\nTerminal=true\nType=Application\nIcon=$astromakase_icon_path\nCategories=Utility;System;\nMimeType=text/html;text/xml;application/xhtml_xml;\nStartupNotify=true"

if [ -f "$desktop_file_path" ] && grep -qF "$desktop_entry_content" "$desktop_file_path"; then
    print_success "AstrOmakase.desktop file is already up-to-date. Skipping creation."
elif echo -e "$desktop_entry_content" | tee "$desktop_file_path" > /dev/null; then
    print_info "Creating/Updating AstrOmakase.desktop file at $desktop_file_path..."
    mkdir -p "$(dirname "$desktop_file_path")" || { print_error "Failed to create desktop file directory."; exit 1; }
    print_success "AstrOmakase.desktop file created/updated successfully."
else
    print_error "Failed to create/update AstrOmakase.desktop file."
    exit 1
fi

# Add execution permissions to the astromakase file idempotently
print_info "Checking permissions for $astromakase_bin_path..."
if [ -f "$astromakase_bin_path" ]; then
    if [ -x "$astromakase_bin_path" ]; then
        print_success "'$astromakase_bin_path' already has execute permissions. Skipping."
    else
        print_info "Adding execute permissions to '$astromakase_bin_path'..."
        if sudo chmod +x "$astromakase_bin_path"; then
            print_success "Execute permissions added to '$astromakase_bin_path'."
        else
            print_error "Failed to add execute permissions to '$astromakase_bin_path'."
            exit 1
        fi
    fi
else
    print_error "AstrOmakase binary not found at $astromakase_bin_path. Cannot set execute permissions."
fi

# Add the path to .bashrc idempotently
local path_export_line="export PATH=\"$HOME/.local/share/astromakase/bin:\$PATH\""
if ! grep -qF "$path_export_line" "$HOME/.bashrc"; then
    print_info "Adding PATH export to ~/.bashrc..."
    echo "" >> "$HOME/.bashrc" # Add a newline for separation
    echo "$path_export_line" >> "$HOME/.bashrc"
    print_success "PATH export added to ~/.bashrc."
else
    print_success "PATH export already exists in ~/.bashrc. Skipping."
fi

print_success "AstrOmakase launcher setup complete."

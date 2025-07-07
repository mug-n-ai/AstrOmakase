#!/bin/bash
set -euo pipefail

# This settings are inspired by the Omakub project. Please visit the [Omakub project](https://github.com/basecamp/omakub) 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting up Ulauncher..."

local ulauncher_autostart_source="$SCRIPT_DIR/config/ulauncher/ulauncher.desktop"
local ulauncher_autostart_dest="$HOME/.config/autostart/ulauncher.desktop"

print_info "Ensuring autostart directory exists..."
mkdir -p "$(dirname "$ulauncher_autostart_dest")" || { print_error "Failed to create autostart directory."; exit 1; }

print_info "Setting up Ulauncher autostart..."
if [ -f "$ulauncher_autostart_source" ]; then
    if [ -f "$ulauncher_autostart_dest" ] && cmp -s "$ulauncher_autostart_source" "$ulauncher_autostart_dest"; then
        print_success "Ulauncher autostart file is already up-to-date. Skipping copy."
    else
        print_info "Copying Ulauncher autostart file..."
        if cp "$ulauncher_autostart_source" "$ulauncher_autostart_dest"; then
            print_success "Ulauncher autostart file copied successfully."
        else
            print_error "Failed to copy Ulauncher autostart file."
            exit 1
        fi
    fi
else
    print_error "Ulauncher autostart source file not found at $ulauncher_autostart_source. Skipping autostart setup."
fi

local ulauncher_settings_source="$SCRIPT_DIR/config/ulauncher/ulauncher.json"
local ulauncher_settings_dest="$HOME/.config/ulauncher/settings.json"

print_info "Setting up Ulauncher configuration..."
if [ -f "$ulauncher_settings_source" ]; then
    # Ensure Ulauncher config directory exists
    mkdir -p "$(dirname "$ulauncher_settings_dest")" || { print_error "Failed to create Ulauncher config directory."; exit 1; }

    if [ -f "$ulauncher_settings_dest" ] && cmp -s "$ulauncher_settings_source" "$ulauncher_settings_dest"; then
        print_success "Ulauncher settings file is already up-to-date. Skipping copy."
    else
        print_info "Copying Ulauncher settings file..."
        if cp "$ulauncher_settings_source" "$ulauncher_settings_dest"; then
            print_success "Ulauncher settings file copied successfully."
            # If settings were updated, try to restart Ulauncher to apply them
            if pgrep -x "ulauncher" > /dev/null; then
                print_info "Restarting Ulauncher to apply new settings..."
                killall ulauncher || true # Kill existing process gracefully
                gtk-launch ulauncher.desktop &>/dev/null &
                print_success "Ulauncher restarted."
            else
                print_info "Ulauncher not running. Starting it to apply new settings..."
                gtk-launch ulauncher.desktop &>/dev/null &
                print_success "Ulauncher started."
            fi
        else
            print_error "Failed to copy Ulauncher settings file."
            exit 1
        fi
    fi
else
    print_error "Ulauncher settings source file not found at $ulauncher_settings_source. Skipping settings setup."
fi

print_success "Ulauncher setup complete."

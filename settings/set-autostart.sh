#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting apps for autostart..."

# Applications to start at boot
startup_apps=(
    "franz.desktop"
    "slack.desktop"
    "dropbox.desktop"
)

# Directory where .desktop files are typically stored
desktop_dirs=(
    "/var/lib/flatpak/exports/share/applications"
    "/usr/share/applications"
    "/usr/local/share/applications"
    "$HOME/.local/share/applications"
)

# Ensure the autostart directory exists
autostart_dir="$HOME/.config/autostart"
print_info "Ensuring autostart directory exists: $autostart_dir"
mkdir -p "$autostart_dir" || { print_error "Failed to create autostart directory."; exit 1; }
print_success "Autostart directory ensured."

# Check if a .desktop file exists for each app and create symlinks idempotently
for app in "${startup_apps[@]}"; do
    local found_source_path=""
    for dir in "${desktop_dirs[@]}"; do
        if [ -f "$dir/$app" ]; then
            found_source_path="$dir/$app"
            break
        fi
    done

    if [ -n "$found_source_path" ]; then
        local target_symlink="$autostart_dir/$app"
        if [ -L "$target_symlink" ] && [ "$(readlink -f "$target_symlink")" = "$(readlink -f "$found_source_path")" ]; then
            print_success "Autostart symlink for '$app' already exists and is correct. Skipping."
        else
            print_info "Setting '$app' to start at boot..."
            if ln -sf "$found_source_path" "$target_symlink"; then
                print_success "Autostart symlink for '$app' created successfully."
            else
                print_error "Failed to create autostart symlink for '$app'."
            fi
        fi
    else
        print_error "Source .desktop file for '$app' not found in common desktop directories. Skipping autostart setup for this app."
    fi
done

print_success "Apps autostart setup completed."

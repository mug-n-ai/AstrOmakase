#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting favorite apps for dock..."

# Favorite apps for dock
apps=(
    "org.gnome.Nautilus.desktop"
    "google-chrome.desktop"
    "dev.warp.Warp.desktop"
    "code.desktop"
    "onlyoffice-desktopeditors.desktop"
    "Activity.desktop"
    "AstrOmakase.desktop"
)

# Array to hold installed favorite apps
installed_apps=()

# Directory where .desktop files are typically stored
desktop_dirs=(
    "/var/lib/flatpak/exports/share/applications"
    "/usr/share/applications"
    "/usr/local/share/applications"
    "$HOME/.local/share/applications"
)

print_info "Checking for existence of specified applications..."
# Check if a .desktop file exists for each app
for app in "${apps[@]}"; do
    local found=false
    for dir in "${desktop_dirs[@]}"; do
        if [ -f "$dir/$app" ]; then
            installed_apps+=("$app")
            found=true
            break
        fi
    done
    if [ "$found" = false ]; then
        print_info "Warning: '$app' not found in any of the specified directories. It will not be added to the dock."
    fi
done

if [ ${#installed_apps[@]} -eq 0 ]; then
    print_info "No favorite apps were found to set. Skipping dock configuration."
else
    # Convert the array to a format suitable for gsettings
    local new_favorites_list="$(printf "'%s'," "${installed_apps[@]}")"
    new_favorites_list="[${new_favorites_list%,}]"

    local current_favorites_list
    current_favorites_list=$(gsettings get org.gnome.shell favorite-apps 2>/dev/null || true)

    if [ "$current_favorites_list" = "$new_favorites_list" ]; then
        print_success "Favorite apps for dock are already set correctly. Skipping update."
    else
        print_info "Setting favorite apps for dock to: $new_favorites_list..."
        if gsettings set org.gnome.shell favorite-apps "$new_favorites_list"; then
            print_success "Favorite apps for dock set successfully."
        else
            print_error "Failed to set favorite apps for dock."
            exit 1
        fi
    fi
fi

print_success "Favorite apps for dock setup completed."

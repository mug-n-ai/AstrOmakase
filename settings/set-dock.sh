#!/bin/bash

echo "Setting favorite apps for dock..."

# Favorite apps for dock
apps=(
    "org.gnome.Nautilus.desktop"
    "google-chrome.desktop"
    "Alacritty.desktop"
    "code.desktop"
    "Activity.desktop"
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

# Check if a .desktop file exists for each app
for app in "${apps[@]}"; do
    found=0
    for dir in "${desktop_dirs[@]}"; do
        if [ -f "$dir/$app" ]; then
            installed_apps+=("$app")
            found=1
            break
        fi
    done
    if [ $found -eq 0 ]; then
        echo "Warning: $app not found in any of the specified directories."
    fi
done

# Convert the array to a format suitable for gsettings
if [ ${#installed_apps[@]} -gt 0 ]; then
    favorites_list=$(printf "'%s'," "${installed_apps[@]}")
    favorites_list="[${favorites_list%,}]"

    # Set the favorite apps
    gsettings set org.gnome.shell favorite-apps "$favorites_list"

    echo "Favorites set to: $favorites_list"
else
    echo "No favorite apps were found to set."
fi

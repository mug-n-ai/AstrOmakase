#!/bin/bash

echo "Setting apps for autostart..."

# Applications to start at boot
startup_apps=(
    "franz.desktop"
    "slack.desktop"
    "dropbox.desktop"
    "nordvpn.desktop"
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
mkdir -p "$autostart_dir"

# Check if a .desktop file exists for each app and create symlinks
for app in "${startup_apps[@]}"; do
    for dir in "${desktop_dirs[@]}"; do
        if [ -f "$dir/$app" ]; then
            ln -sf "$dir/$app" "$autostart_dir/$app"
            echo "Setting $app to start at boot."
            break
        fi
    done
done

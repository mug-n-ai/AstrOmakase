#!/bin/bash

echo "Setting GNOME wallpaper..."

INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WALLPAPER="$INSTALL_DIR/../content/wallpaper.jpg"

# Check if the wallpaper file exists
if [[ -f "$WALLPAPER" ]]; then
    echo "Wallpaper file found: $WALLPAPER"

    # Set the wallpaper for GNOME
    gsettings set org.gnome.desktop.background picture-uri "file://$WALLPAPER"
    gsettings set org.gnome.desktop.background picture-options "zoom"

    # Verify the change
    CURRENT_WALLPAPER=$(gsettings get org.gnome.desktop.background picture-uri)
    CURRENT_OPTIONS=$(gsettings get org.gnome.desktop.background picture-options)

    if [[ "$CURRENT_WALLPAPER" == "'file://$WALLPAPER'" && "$CURRENT_OPTIONS" == "'zoom'" ]]; then
        echo "Wallpaper successfully set to $WALLPAPER with zoomed options."
    else
        echo "Failed to set wallpaper."
        echo "Current wallpaper: $CURRENT_WALLPAPER"
        echo "Current options: $CURRENT_OPTIONS"
    fi
else
    echo "Wallpaper file not found: $WALLPAPER"
    exit 1
fi

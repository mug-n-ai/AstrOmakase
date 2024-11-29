#!/bin/bash

echo "Setting GNOME wallpaper..."

WALLPAPER="$INSTALL_DIR/content/wallpaper.png"

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
        echo "Wallpaper successfully set to $WALLPAPER with fitted options."
    else
        echo "Failed to set wallpaper."
        echo "Current wallpaper: $CURRENT_WALLPAPER"
        echo "Current options: $CURRENT_OPTIONS"
    fi
else
    echo "Wallpaper file not found: $WALLPAPER"
    exit 1
fi

# Set GNOME settings
# never suspend if plugged in
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0

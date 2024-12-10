# This settings are inspired by the Omakub project. Please visit the [Omakub project](https://github.com/basecamp/omakub) 

#!/bin/bash

echo "Setting Gnome Colors..."

gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface cursor-theme 'Yaru'
gsettings set org.gnome.desktop.interface gtk-theme "Yaru-blue-dark"
gsettings set org.gnome.desktop.interface icon-theme "Yaru-blue"


echo "Setting GNOME wallpaper..."

WALLPAPER="$INSTALL_DIR/content/wallpaper.png"

# Check if the wallpaper file exists
if [[ -f "$WALLPAPER" ]]; then
    echo "Wallpaper file found: $WALLPAPER"

    WALLPAPER_DEST_DIR="$HOME/.local/share/backgrounds"
    WALLPAPER_DEST_PATH="$WALLPAPER_DEST_DIR/wallpaper.png"

    if [ ! -d "$WALLPAPER_DEST_DIR" ]; then mkdir -p "$WALLPAPER_DEST_DIR"; fi

    [ ! -f $WALLPAPER_DEST_DIR ] && cp $WALLPAPER $WALLPAPER_DEST_DIR
    gsettings set org.gnome.desktop.background picture-uri $WALLPAPER_DEST_DIR
    gsettings set org.gnome.desktop.background picture-uri-dark $WALLPAPER_DEST_DIR
    gsettings set org.gnome.desktop.background picture-options 'zoom'

else
    echo "Wallpaper file not found: $WALLPAPER"
    exit 1
fi

# Set GNOME settings
# never suspend if plugged in
gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 0

# Center new windows in the middle of the screen
gsettings set org.gnome.mutter center-new-windows true

# Reveal week numbers in the Gnome calendar
gsettings set org.gnome.desktop.calendar show-weekdate true

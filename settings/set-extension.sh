#!/bin/bash

# enable Ubuntu AppIndicators
gnome-extensions enable ubuntu-appindicators@ubuntu.com

# Configure TopHat
gsettings set org.gnome.shell.extensions.tophat show-icons true
gsettings set org.gnome.shell.extensions.tophat show-cpu true
gsettings set org.gnome.shell.extensions.tophat show-disk false
gsettings set org.gnome.shell.extensions.tophat show-mem true
gsettings set org.gnome.shell.extensions.tophat cpu-display numeric
gsettings set org.gnome.shell.extensions.tophat mem-display numeric
gsettings set org.gnome.shell.extensions.tophat network-usage-unit bits
gsettings set org.gnome.shell.extensions.tophat show-animations false

# Set TopHat color based on the current theme
theme=$(gsettings get org.gnome.desktop.interface icon-theme)

case $theme in
    "'Yaru-purple'")
        color="#924d8b"
        ;;
    "'Yaru-red'")
        color="#e92020"
        ;;
    "'Yaru-blue'")
        color="#208fe9"
        ;;
    "'Yaru-sage'"|"'Yaru-bark'")
        color="#78ab50"
        ;;
    "'Yaru-magenta'")
        color="#e920a3"
        ;;
    *)
        echo "No matching theme found."
        exit 1
        ;;
esac

# Set the TopHat color
gsettings set org.gnome.shell.extensions.tophat meter-fg-color "$color"


# configure Alphabetical App Grid
gsettings set org.gnome.shell.extensions.alphabetical-app-grid folder-order-position 'end'

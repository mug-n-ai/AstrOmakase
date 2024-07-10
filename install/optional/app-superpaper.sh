#!/bin/bash

# Directory where the AppImage will be stored
mkdir -p ~/Applications
cd ~/Applications

# Download the Superpaper AppImage
wget https://github.com/hhannine/superpaper/releases/download/v2.2.1/Superpaper-2.2.1-x86_64.AppImage

# Make the AppImage executable
chmod +x Superpaper-2.2.1-x86_64.AppImage

# Create a desktop entry for Superpaper
cat <<EOF > ~/.local/share/applications/superpaper.desktop
[Desktop Entry]
Name=Superpaper
Exec=$HOME/Applications/Superpaper-2.2.1-x86_64.AppImage
Icon=$HOME/Applications/superpaper.png
Type=Application
Categories=Utility;
EOF

# Optional: Download an icon for Superpaper
wget -O $HOME/Applications/superpaper.png https://github.com/hhannine/superpaper/raw/master/src/superpaper/gui/icons/icon.png

# Refresh desktop database
update-desktop-database ~/.local/share/applications/

# Go back to the previous directory
cd -
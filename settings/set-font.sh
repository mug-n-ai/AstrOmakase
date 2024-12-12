#!/bin/bash

echo "Installing Fira Code Nerd Font..."

# Create the fonts directory if it doesn't exist
mkdir -p ~/.local/share/fonts

# Download and install Cascadia Code Nerd Font
cd /tmp
wget https://github.com/rsms/inter/releases/download/v3.19/Inter-3.19.zip
unzip Inter-3.19.zip -d InterFont
cp InterFont/*.ttf ~/.local/share/fonts
rm -rf Inter-3.19.zip InterFont


# Refresh font cache
fc-cache -fv

# Apply Cascadia Code Nerd Font as default font for the system
gsettings set org.gnome.desktop.interface monospace-font-name 'Inter Mono 10'
gsettings set org.gnome.desktop.interface font-name 'Inter 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Inter Bold 10'




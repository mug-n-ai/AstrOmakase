#!/bin/bash

echo "Installing Fira Code Nerd Font..."

# Create the fonts directory if it doesn't exist
mkdir -p ~/.local/share/fonts

# Download and install Fira Code Nerd Font
cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraCode.zip
unzip FiraCode.zip -d FiraFont
cp FiraFont/*.ttf ~/.local/share/fonts
rm -rf FiraCode.zip FiraFont

# Refresh font cache
fc-cache -fv

# Apply Fira Code Nerd Font as default font for the system
gsettings set org.gnome.desktop.interface monospace-font-name 'FiraCode Nerd Font 10'
gsettings set org.gnome.desktop.interface font-name 'FiraCode Nerd Font 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'FiraCode Nerd Font Bold 10'



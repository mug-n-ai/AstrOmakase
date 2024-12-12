#!/bin/bash

echo "Installing Inter Font..."

# Create the fonts directory if it doesn't exist
mkdir -p ~/.local/share/fonts

# Fetch the latest release of Inter Font
cd /tmp
latest_release=$(curl -s https://api.github.com/repos/rsms/inter/releases/latest | grep "browser_download_url.*zip" | cut -d '"' -f 4)

# Check if the URL was fetched successfully
if [[ -z "$latest_release" ]]; then
    echo "Failed to fetch the latest release URL. Exiting."
    exit 1
fi

echo "Downloading Inter Font from: $latest_release"
wget -O Inter.zip "$latest_release"

# Unzip the downloaded file
unzip Inter.zip -d InterFont

# Copy the TTF files to the fonts directory
if ls InterFont/*.ttf &>/dev/null; then
    cp InterFont/*.ttf ~/.local/share/fonts
else
    echo "No .ttf files found in the release archive. Exiting."
    rm -rf Inter.zip InterFont
    exit 1
fi

# Clean up temporary files
rm -rf Inter.zip InterFont

# Refresh font cache
fc-cache -fv

# Apply Inter Font as default font for the system
gsettings set org.gnome.desktop.interface monospace-font-name 'Inter Mono 10'
gsettings set org.gnome.desktop.interface font-name 'Inter 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Inter Bold 10'

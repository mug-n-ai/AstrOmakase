#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Inter Font and Cascadia Code Nerd Font..."

# Create the fonts directory if it doesn't exist
mkdir -p ~/.local/share/fonts

# Fetch the latest release of Inter Font
cd /tmp
inter_latest_release=$(curl -s https://api.github.com/repos/rsms/inter/releases/latest | grep "browser_download_url.*zip" | cut -d '"' -f 4)

# Check if the Inter URL was fetched successfully
if [[ -z "$inter_latest_release" ]]; then
    echo "Failed to fetch the latest Inter release URL. Exiting."
    exit 1
fi

echo "Downloading Inter Font from: $inter_latest_release"
wget -O Inter.zip "$inter_latest_release"

# Unzip the downloaded Inter font
unzip Inter.zip -d InterFont

# Copy Inter TTF files to the fonts directory
if ls InterFont/*.ttf &>/dev/null; then
    cp InterFont/*.ttf ~/.local/share/fonts
else
    echo "No .ttf files found in the Inter release archive. Exiting."
    rm -rf Inter.zip InterFont
    exit 1
fi

# Fetch the latest release of Cascadia Code Nerd Font
cascadia_latest_release="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip"

echo "Downloading Cascadia Code Nerd Font from: $cascadia_latest_release"
wget -O CascadiaCode.zip "$cascadia_latest_release"

# Unzip the downloaded Cascadia font
unzip CascadiaCode.zip -d CascadiaFont

# Copy Cascadia TTF files to the fonts directory
if ls CascadiaFont/*.ttf &>/dev/null; then
    cp CascadiaFont/*.ttf ~/.local/share/fonts
else
    echo "No .ttf files found in the Cascadia release archive. Exiting."
    rm -rf CascadiaCode.zip CascadiaFont
    exit 1
fi

# Clean up temporary files
rm -rf Inter.zip InterFont CascadiaCode.zip CascadiaFont

# Refresh font cache
fc-cache -fv

# Apply Inter Font as default font for the system
gsettings set org.gnome.desktop.interface font-name 'Inter 10'
gsettings set org.gnome.desktop.wm.preferences titlebar-font 'Inter Bold 10'

# Apply Cascadia Code Nerd Font as monospace font
gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaCove Nerd Font 10'

print_success "Inter and Cascadia Code Nerd Fonts installed and applied successfully!"

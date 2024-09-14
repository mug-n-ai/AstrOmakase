#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

# Directory for the fonts
FONT_DIR="$HOME/.fonts"
mkdir -p "$FONT_DIR"

# Function to install a font
install_font() {
    FONT_NAME=$1
    FONT_URL=$2

    echo "Installing $FONT_NAME..."

    # Download the font
    wget -q "$FONT_URL" -O "$FONT_DIR/$FONT_NAME"
    
    # If it's a zip file, extract only the .ttf files and remove the zip
    if [[ "$FONT_NAME" == *.zip ]]; then
        unzip -jo "$FONT_DIR/$FONT_NAME" "*.ttf" -d "$FONT_DIR" # Extract only .ttf files into ~/.fonts
        rm "$FONT_DIR/$FONT_NAME" # Remove the zip file after extraction
    fi

    # Check the result of the operation
    if [ $? -eq 0 ]; then
        print_success "$FONT_NAME installed successfully."
    else
        print_error "Failed to install $FONT_NAME."
    fi
}

# Cascadia Mono (zip file)
install_font "CascadiaCode.zip" "https://github.com/microsoft/cascadia-code/releases/download/v2106.17/CascadiaCode-2106.17.zip"

# Helvetica (Nimbus Sans L open-source alternative, zip file)
install_font "NimbusSansL.zip" "https://github.com/ArtifexSoftware/urw-base35-fonts/archive/refs/heads/master.zip"

# iafonts (Input Mono - direct download)
install_font "InputMono.ttf" "https://input.djr.com/build/?fontSelection=mono&language=english&name=InputMono&export=ttf"

# Roboto (single .ttf file)
install_font "Roboto.ttf" "https://github.com/google/fonts/blob/main/apache/roboto/Roboto%5Bwdth%2Cwght%5D.ttf?raw=true"

# Times New Roman (Tinos as an open-source alternative, single .ttf file)
install_font "Tinos.ttf" "https://github.com/google/fonts/raw/main/apache/tinos/Tinos%5Bwght%5D.ttf"

# Update the font cache
fc-cache -fv

print_success "All fonts installed and font cache updated."

#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"


# Destination directory for the AppImage
FONT_DIR="$HOME/.fonts"
mkdir -p $FONT_DIR

FONT_SOURCE="$HOME/.fonts"

# Define the source directory (parent of the current directory)
FONT_SOURCE="$(cd "$(dirname "${BASH_SOURCE[0]}")/../content/fonts" && pwd)"

echo "Installing fonts..."

# Check if the directory exists
if [ -d "$FONT_SOURCE" ]; then
    echo "Looking for .zip files in $FONT_SOURCE..."
else
    print_error "Directory $FONT_SOURCE does not exist. Exiting..."
    exit 1
fi

# Loop through all .zip files in the directory
for zip_file in "$FONT_SOURCE"/*.zip; do
    if [ -f "$zip_file" ]; then
        echo "Extracting $zip_file..."

        # Create a temporary directory to extract the files
        TEMP_DIR=$(mktemp -d)

        # Extract the zip file into the temporary directory
        unzip -q "$zip_file" -d "$TEMP_DIR"

        # Find all .ttf files and copy them to the font directory
        find "$TEMP_DIR" -type f -name "*.ttf" -exec cp {} "$FONT_DIR" \;

        # Clean up temporary directory
        rm -rf "$TEMP_DIR"
    else
        print_error "No zip files found in $FONT_SOURCE."
    fi
done

echo "Updating font cache..."
fc-cache -f 

print_success "Font extraction completed. TTF files have been copied to $FONT_DIR."


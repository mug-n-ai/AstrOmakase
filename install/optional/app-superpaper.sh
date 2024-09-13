#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"

APP_DIR="$HOME/Applications"
SUPERPAPER_APPIMAGE="$APP_DIR/Superpaper-latest-x86_64.AppImage"

# Function to install or update Superpaper
install_superpaper() {
    # Fetch the latest version available on GitHub
    LATEST_VERSION=$(curl -s https://api.github.com/repos/hhannine/superpaper/releases/latest | grep "tag_name" | cut -d '"' -f 4)

    if [ -z "$LATEST_VERSION" ]; then
        print_error "Unable to find the latest version. Check your internet connection or the API URL."
        exit 1
    fi

    # Remove the 'v' character from LATEST_VERSION for the file name
    FILE_VERSION=${LATEST_VERSION#v}

    # Create the URL for downloading the AppImage
    URL="https://github.com/hhannine/superpaper/releases/download/$LATEST_VERSION/Superpaper-$FILE_VERSION-x86_64.AppImage"

    # Create the Applications directory if it doesn't exist
    mkdir -p $APP_DIR

    # Download the AppImage
    wget -O $SUPERPAPER_APPIMAGE $URL
    if [ $? -ne 0 ]; then
        print_error "Failed to download Superpaper. Exiting."
        exit 1
    fi

    # Check if the file was downloaded successfully
    if [ -f "$SUPERPAPER_APPIMAGE" ]; then
        print_success "Successfully downloaded Superpaper version $LATEST_VERSION."
    else
        print_error "The file was not found after download. Something went wrong."
        exit 1
    fi

    echo "Downloaded Superpaper version $LATEST_VERSION"

    # Make the AppImage executable
    chmod +x $SUPERPAPER_APPIMAGE

    # Create a desktop entry for Superpaper
    cat <<EOF > ~/.local/share/applications/superpaper.desktop
[Desktop Entry]
Name=Superpaper
Exec=$SUPERPAPER_APPIMAGE
Icon=$HOME/Applications/superpaper.png
Type=Application
Categories=Utility;
EOF

    # Optional: Download an icon for Superpaper
    wget -O $HOME/Applications/superpaper.png https://github.com/hhannine/superpaper/blob/master/superpaper/resources/superpaper.png

    # Refresh desktop database
    update-desktop-database ~/.local/share/applications/

    print_success "Installed Superpaper version $LATEST_VERSION"
}

# Check if Superpaper is already installed
if [ -f "$SUPERPAPER_APPIMAGE" ]; then
    echo "Superpaper is already installed at $SUPERPAPER_APPIMAGE."

    # Ask user if they want to overwrite the existing file using Gum
    if gum confirm "Superpaper is already installed. Do you want to overwrite it with the latest version?" --default=false; then
        echo "Updating Superpaper..."
        install_superpaper
    else
        echo "Skipping installation."
    fi
else
    install_superpaper
fi

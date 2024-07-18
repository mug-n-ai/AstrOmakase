#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define installation directory
INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$INSTALL_DIR/common_functions.sh"

ascii_art='AstrOmakase'

echo -e "$ascii_art"
echo "=> AstrOmakase is for fresh Ubuntu 24.04 installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

# Check if the running system is Ubuntu 24.04
if ! lsb_release -d | grep -q "Ubuntu 24.04"; then
    print_error "This script is designed for Ubuntu 24.04. Exiting."
    exit 1
fi


if $RUNNING_GNOME; then
	# Ensure computer doesn't go to sleep or lock while installing
	gsettings set org.gnome.desktop.screensaver lock-enabled false
	gsettings set org.gnome.desktop.session idle-delay 0
fi



# Define the options and corresponding script names
OPTIONAL_APPS=("Discord" "Franz" "LaTex" "nordvpn" "scrcpy" "Slack" "speedtest" "superpaper" "Upscayl")
OPTIONAL_SCRIPTS=("app-discord" "app-franz" "app-latex" "app-nordvpn" "app-scrcpy" "app-slack" "app-speedtest" "app-superpaper" "app-upscayl")

# Inform the user about the default behavior
echo "Please select the optional applications you want to install. If you press Enter without selecting any, all applications will be installed by default."

# Use Gum to present the options and get user input
SELECTED_APPS=$(gum choose --no-limit "${OPTIONAL_APPS[@]}")

# Check if the user made a selection
if [ -z "$SELECTED_APPS" ]; then
    # No selection made, use all apps by default
    SELECTED_APPS=("${OPTIONAL_APPS[@]}")
else
    # Convert the space-separated string to an array
    SELECTED_APPS=($SELECTED_APPS)
fi


OMAKUB_DIR="$HOME/.local/share/omakub"

if [ ! -d "$OMAKUB_DIR" ]; then
    echo "The default omakub directory was not found."
    echo "For a better experience we suggest to start from Omakub installation."
    echo "Please check if the package is installed."
    read -p "Do you want to proceed anyway? (y/n): " response

    if [[ "$response" != "y" && "$response" != "Y" ]]; then
        echo "Operation cancelled by the user."
        exit 1
    fi
fi

# Install installers first
echo "Preparing installers tools..."
source "$INSTALL_DIR/installers.sh"


# Uninstall un-needed Omakub software
echo "Removing un-needed tools"
TO_REMOVE_APP=("1password" "audacity" "ollama" "pinta" "signal" "spotify" "steam" "web" "rubymine")
for app in "${TO_REMOVE_APP[@]}"; do
    echo "Uninstalling ${app}..."
    if ! source "$OMAKUB_DIR/uninstall/app-${app}.sh"; then
        echo "Failed to uninstall ${app}. It might not be installed."
    fi
done

# Install additional tools
echo "Installing AstrOmakase tools..."
for installer in $INSTALL_DIR/install/*.sh; do source $installer; done


# Install the selected optional software
for app in "${SELECTED_APPS[@]}"; do

    # Find the index of the selected app
    for i in "${!OPTIONAL_APPS[@]}"; do
        if [[ "${OPTIONAL_APPS[$i]}" == "$app" ]]; then
            echo "Installing ${OPTIONAL_APPS[$i]}..."
            source "$INSTALL_DIR/install/optional/${OPTIONAL_SCRIPTS[$i]}.sh"
        fi
    done
done



# Settings the tools
echo "Setting environment..."
for setter in $INSTALL_DIR/settings/*.sh; do source $setter; done

# Set the wallpaper for GNOME
gsettings set org.gnome.desktop.background picture-uri "$INSTALL_DIR/content/wallpaper.jpg"
gsettings set org.gnome.desktop.background picture-options "scaled"


echo "AstrOmakase installation and customization complete!"

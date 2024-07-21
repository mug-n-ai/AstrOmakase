#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define installation directory
INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$INSTALL_DIR/common_functions.sh"

# running pre install checks
source "$INSTALL_DIR/preinstall_checks.sh"


# Define the options and corresponding script names
OPTIONAL_APPS=("Brave"  "Dropbox" "Franz" "LaTex" "nordvpn" "scrcpy" "Slack" "speedtest" "superpaper" "Upscayl")
OPTIONAL_SCRIPTS=("app-brave" "app-dropbox" "app-discord" "app-franz" "app-latex" "app-nordvpn" "app-scrcpy" "app-slack" "app-speedtest" "app-superpaper" "app-upscayl")

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


# Install required tools first
echo "Preparing required tools..."
source "$INSTALL_DIR/required.sh"


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

if $RUNNING_GNOME; then
	gsettings set org.gnome.desktop.screensaver lock-enabled true
	gsettings set org.gnome.desktop.session idle-delay 300
fi

echo "AstrOmakase installation and customization complete!"

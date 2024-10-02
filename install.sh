#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define installation directory
INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$INSTALL_DIR/common_functions.sh"

source "$INSTALL_DIR/ascii.sh"
echo "version $(cat version)"

# running pre install checks
source "$INSTALL_DIR/preinstall_checks.sh"

# Define the options and corresponding script names
OPTIONAL_APPS=("Install all" "Brave" "Dropbox" "Franz" "gdm-settings" "LaTex" "nordvpn" "remmina" "scrcpy" "Slack" "speedtest" "superpaper" "Upscayl")
OPTIONAL_SCRIPTS=("app-brave" "app-dropbox" "app-discord" "app-franz" "app-gdm-settings" "app-latex" "app-nordvpn" "app-remmina" "app-scrcpy" "app-slack" "app-speedtest" "app-superpaper" "app-upscayl")

# Inform the user about the selection
echo "Select the optional applications you want to install. You can select 'Install all' to install every application."

# Use Gum to present the options and get user input
SELECTED_APPS=$(gum choose --no-limit "${OPTIONAL_APPS[@]}")

# Convert the space-separated string to an array, handling spaces in names
mapfile -t SELECTED_APPS_ARRAY <<< "$SELECTED_APPS"

# Check if "Install all" was selected
INSTALL_ALL=false
for APP in "${SELECTED_APPS_ARRAY[@]}"; do
    if [ "$APP" == "Install all" ]; then
        INSTALL_ALL=true
        break
    fi
done

# If "Install all" is selected, override all other selections and install everything
if [ "$INSTALL_ALL" = true ]; then
    echo "'Install all' selected. Installing all applications."
    SELECTED_APPS=("${OPTIONAL_APPS[@]:1}")  # Exclude "Install all" from the list
else
    # Use only the selected apps
    SELECTED_APPS=("${SELECTED_APPS_ARRAY[@]}")
    echo "Installing the following optional applications: ${SELECTED_APPS[*]}"
fi

# Install required tools first
echo "Preparing required tools..."
source "$INSTALL_DIR/required.sh"

# Run migrations if necessary
echo "Running preparatory migrations..."
source "$INSTALL_DIR/migrations.sh"

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

gum confirm "Ready to logout for all settings to take effect?" && gnome-session-quit --logout --no-prompt

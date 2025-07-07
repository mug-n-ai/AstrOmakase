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
declare -A OPTIONAL_APPS_MAP
OPTIONAL_APPS_MAP["Brave"]="app-brave"
OPTIONAL_APPS_MAP["Dropbox"]="app-dropbox"
OPTIONAL_APPS_MAP["Franz"]="app-franz"
OPTIONAL_APPS_MAP["gdm-settings"]="app-gdm-settings"
OPTIONAL_APPS_MAP["LaTex"]="app-latex"
OPTIONAL_APPS_MAP["nordvpn"]="app-nordvpn"
OPTIONAL_APPS_MAP["remmina"]="app-remmina"
OPTIONAL_APPS_MAP["scrcpy"]="app-scrcpy"
OPTIONAL_APPS_MAP["Slack"]="app-slack"
OPTIONAL_APPS_MAP["speedtest"]="app-speedtest"
OPTIONAL_APPS_MAP["superpaper"]="app-superpaper"
OPTIONAL_APPS_MAP["Upscayl"]="app-upscayl"
OPTIONAL_APPS_MAP["Discord"]="app-discord" # Added Discord as it was in OPTIONAL_SCRIPTS but not OPTIONAL_APPS

OPTIONAL_APP_NAMES=("Install all")
for app_name in "${!OPTIONAL_APPS_MAP[@]}"; do
    OPTIONAL_APP_NAMES+=("$app_name")
done

# Inform the user about the selection
echo "Select the optional applications you want to install. You can select 'Install all' to install every application."

# Use Gum to present the options and get user input
SELECTED_APPS_RAW=$(gum choose --no-limit "${OPTIONAL_APP_NAMES[@]}")

# Convert the space-separated string to an array
IFS=$'\n' read -d '' -r -a SELECTED_APPS_ARRAY <<< "$SELECTED_APPS_RAW"

# Determine which apps to install
APPS_TO_INSTALL=()
if printf '%s\n' "${SELECTED_APPS_ARRAY[@]}" | grep -q -x "Install all"; then
    echo "'Install all' selected. Installing all optional applications."
    for app_name in "${!OPTIONAL_APPS_MAP[@]}"; do
        APPS_TO_INSTALL+=("${OPTIONAL_APPS_MAP[$app_name]}")
    done
else
    echo "Installing the following optional applications: ${SELECTED_APPS_ARRAY[*]}"
    for app_name in "${SELECTED_APPS_ARRAY[@]}"; do
        if [[ -n "${OPTIONAL_APPS_MAP[$app_name]}" ]]; then
            APPS_TO_INSTALL+=("${OPTIONAL_APPS_MAP[$app_name]}")
        fi
    done
fi

# Install required tools first
echo "Preparing required tools..."
source "$INSTALL_DIR/required.sh"

# Run migrations if necessary
echo "Running preparatory migrations..."
source "$INSTALL_DIR/migrations.sh"

# Install additional tools
echo "Installing AstrOmakase tools..."
for installer in "$INSTALL_DIR"/install/*.sh; do source "$installer"; done

# Install the selected optional software
for script_name in "${APPS_TO_INSTALL[@]}"; do
    echo "Installing ${script_name}..."
    source "$INSTALL_DIR/install/optional/${script_name}.sh"
done

echo "Installing applications..."
for application in "$INSTALL_DIR"/applications/*.sh; do source "$application"; done

# Settings the tools
echo "Setting environment..."
for setter in "$INSTALL_DIR"/settings/*.sh; do source "$setter"; done

if $RUNNING_GNOME; then
    gsettings set org.gnome.desktop.screensaver lock-enabled true
    gsettings set org.gnome.desktop.session idle-delay 300
fi

echo "AstrOmakase installation and customization complete!"

gum confirm "Ready to logout for all settings to take effect?" && gnome-session-quit --logout --no-prompt
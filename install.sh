
# Exit immediately if a command exits with a non-zero status
set -e

# Define installation directory
INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"


ascii_art='   _____            __         ________                  __        ___.    
  /  _  \   _______/  |________\_____  \   _____ _____  |  | ____ _\_ |__  
 /  /_\  \ /  ___/\   __\_  __ \/   |   \ /     \\__  \ |  |/ /  |  \ __ \ 
/    |    \\___ \  |  |  |  | \/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\____|__  /____  > |__|  |__|  \_______  /__|_|  (____  /__|_ \____/|___  /
        \/     \/                      \/      \/     \/     \/         \/ 
'

echo -e "$ascii_art"
echo "=> AstrOmakub is for fresh Ubuntu 24.04 installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

# Define the options and corresponding script names
OPTIONAL_APPS=("Discord" "Franz" "LaTex" "nordvpn" "scrcpy" "Slack" "speedtest" "superpaper" "Teams" "Upscayl")
OPTIONAL_SCRIPTS=("app-discord" "app-franz" "app-latex" "app-nordvpn" "app-scrcpy" "app-slack" "app-speedtest" "app-superpaper" "app-teams" "app-upscayl")

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
echo "Installing additional tools..."
for installer in $INSTALL_DIR/install/*.sh; do source $installer; done

# Ask the user which optional software to install
echo "Please select the optional software you want to install:"


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


# Install additional tools
echo "Setting environment..."
for setter in $INSTALL_DIR/settings/*.sh; do source $setter; done

# Set the wallpaper for GNOME
if [[ "$XDG_CURRENT_DESKTOP" == "GNOME" ]]; then
    gsettings set org.gnome.desktop.background picture-uri "$INSTALL_DIR/content/wallpaper.jpg"
    gsettings set org.gnome.desktop.background picture-options "scaled"
fi


echo "AstrOmakub installation and customization complete!"

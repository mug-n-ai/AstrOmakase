
# Exit immediately if a command exits with a non-zero status
set -e

# Define installation directory
INSTALL_DIR="."


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


# Step 1: Install Omakub
echo "Installing Omakub..."
mkdir -p $INSTALL_DIR
cd $INSTALL_DIR
wget -qO- https://omakub.org/install | bash

# Step 2: Install additional tools
echo "Installing additional tools..."
for installer in $INSTALL_DIR/install/*.sh; do source $installer; done

# Step 3: Ask the user which optional software to install
echo "Please select the optional software you want to install:"

# Define the options and corresponding script names
OPTIONAL_APPS=("Zoom" "Dropbox" "Discord" "Franz" "LaTex" "nordvpn" "scrcpy" "Slack" "speedtest" "superpaper" "Teams")
OPTIONAL_SCRIPTS=("app-zoom" "app-dropbox" "app-discord" "app-franz" "app-latex" "app-nordvpn" "app-scrcpy" "app-slack" "app-speedtest" "app-superpaper" "app-teams")

# Use Gum to present the options and get user input
SELECTED_APPS=$(gum choose --no-limit "${OPTIONAL_APPS[@]}")

# Install the selected optional software
for app in $SELECTED_APPS; do
    # Find the index of the selected app
    for i in "${!OPTIONAL_APPS[@]}"; do
        if [[ "${OPTIONAL_APPS[$i]}" == "$app" ]]; then
            echo "Installing ${OPTIONAL_APPS[$i]}..."
            source "$INSTALL_DIR/install/optional/${OPTIONAL_SCRIPTS[$i]}.sh"
        fi
    done
done


echo "AstrOmakub installation and customization complete!"

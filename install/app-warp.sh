#!/bin/bash

# Define the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

# Define constants
THEME_NAME="Tokyo Night"
DEFAULT_THEME_PATH="${HOME}/.local/share/warp-terminal/themes/tokyo_night.yaml"
PREFS_FILE="${HOME}/.config/warp-terminal/user_preferences.json"
DEFAULT_CONFIG_FILE="$INSTALL_DIR/settings/config/warp-terminal/user_preferences.json"

echo "Starting Warp terminal setup..."

# Function to install Warp terminal
install_warp_terminal() {
    echo "Checking if Warp terminal is already installed..."
    if command_exists warp-terminal; then
        print_success "Warp terminal is already installed. Exiting installation step."
        return
    fi

    echo "Installing Warp terminal..."
    wget -qO- https://releases.warp.dev/linux/keys/warp.asc | gpg --dearmor > warpdotdev.gpg
    sudo install -D -o root -g root -m 644 warpdotdev.gpg /etc/apt/keyrings/warpdotdev.gpg
    sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/warpdotdev.gpg] https://releases.warp.dev/linux/deb stable main" > /etc/apt/sources.list.d/warpdotdev.list'
    rm warpdotdev.gpg
    sudo apt update && sudo apt install warp-terminal -y

    if [[ $? -ne 0 ]]; then
        print_error "Failed to install Warp terminal. Exiting."
        exit 1
    fi
    print_success "Warp terminal installed successfully."
}

# Function to copy themes
copy_themes() {
    echo "Copying theme files..."
    mkdir -p "${XDG_DATA_HOME:-$HOME/.local/share}/warp-terminal/themes/"
    cp "$INSTALL_DIR/themes/warp-terminal/"* "${XDG_DATA_HOME:-$HOME/.local/share}/warp-terminal/themes/"

    if [[ $? -ne 0 ]]; then
        print_error "Failed to copy theme files. Exiting."
        exit 1
    fi
    print_success "Theme files copied successfully."
}

# Function to update preferences file
update_preferences() {
    echo "Configuring Warp terminal preferences..."

    # Check if the preferences file exists
    if [[ ! -f "$PREFS_FILE" ]]; then
        echo "Preferences file not found. Using default configuration..."
        
        # Create config directory if it doesn't exist
        mkdir -p "$(dirname "$PREFS_FILE")"

        # Copy default configuration and update theme path
        jq --arg theme_name "$THEME_NAME" \
            --arg theme_path "$DEFAULT_THEME_PATH" \
            '.prefs.Theme = {"Custom": {"name": $theme_name, "path": $theme_path}}' \
            "$DEFAULT_CONFIG_FILE" > "$PREFS_FILE"

        if [[ $? -ne 0 ]]; then
            print_error "Failed to prepare preferences file from default configuration."
            exit 1
        fi

        print_success "Preferences file created using default configuration."
        return
    fi
}

# Main script execution
install_warp_terminal
copy_themes
update_preferences

echo "Warp terminal setup completed successfully."

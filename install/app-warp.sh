#!/bin/bash
set -euo pipefail

# Define the script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Warp terminal..."

# Define constants
THEME_NAME="Tokyo Night"
DEFAULT_THEME_PATH="${HOME}/.local/share/warp-terminal/themes/tokyo_night.yaml"
PREFS_FILE="${HOME}/.config/warp-terminal/user_preferences.json"
INSTALL_DIR="$(dirname "$SCRIPT_DIR")" # Assuming INSTALL_DIR is the project root
DEFAULT_CONFIG_FILE="$INSTALL_DIR/settings/config/warp-terminal/user_preferences.json"

# Function to install Warp terminal
install_warp_terminal() {
    print_info "Checking if Warp terminal is already installed..."
    if command_exists warp-terminal; then
        print_success "Warp terminal is already installed. Skipping installation step."
        return 0
    }

    print_info "Warp terminal not found. Proceeding with installation."

    local repo_added=false

    # Add GPG key
    print_info "Adding Warp terminal GPG key..."
    if [ ! -f /etc/apt/keyrings/warpdotdev.gpg ]; then
        if wget -qO- https://releases.warp.dev/linux/keys/warp.asc | gpg --dearmor > /tmp/warpdotdev.gpg && 
           sudo install -D -o root -g root -m 644 /tmp/warpdotdev.gpg /etc/apt/keyrings/warpdotdev.gpg && 
           rm /tmp/warpdotdev.gpg; then
            print_success "Warp terminal GPG key added."
            repo_added=true
        else
            print_error "Failed to add Warp terminal GPG key."
            return 1
        fi
    else
        print_success "Warp terminal GPG key already exists."
    fi

    # Add Warp terminal repository
    print_info "Adding Warp terminal repository..."
    if [ ! -f /etc/apt/sources.list.d/warpdotdev.list ]; then
        if sudo sh -c 'echo "deb [arch=amd64 signed-by=/etc/apt/keyrings/warpdotdev.gpg] https://releases.warp.dev/linux/deb stable main" > /etc/apt/sources.list.d/warpdotdev.list'; then
            print_success "Warp terminal repository added."
            repo_added=true
        else
            print_error "Failed to add Warp terminal repository."
            return 1
        fi
    else
        print_success "Warp terminal repository already exists."
    fi

    if [ "$repo_added" = true ]; then
        print_info "Updating apt package list after adding new repository..."
        if sudo apt update; then
            print_success "Apt package list updated."
        else
            print_error "Failed to update apt package list."
            return 1
        fi
    fi

    # Install warp-terminal package
    print_info "Installing warp-terminal package..."
    if sudo apt install -y warp-terminal; then
        print_success "warp-terminal package installed successfully."
    else
        print_error "Failed to install warp-terminal package."
        return 1
    fi

    print_success "Warp terminal installation completed."
    return 0
}

# Function to copy themes
copy_themes() {
    print_info "Copying theme files..."
    local theme_source_dir="$INSTALL_DIR/themes/warp-terminal/"
    local theme_dest_dir="${XDG_DATA_HOME:-$HOME/.local/share}/warp-terminal/themes/"

    if [ ! -d "$theme_source_dir" ]; then
        print_error "Theme source directory not found: $theme_source_dir. Skipping theme copy."
        return 1
    }

    mkdir -p "$theme_dest_dir" || { print_error "Failed to create theme destination directory."; return 1; }

    local copied_any=false
    for theme_file in "$theme_source_dir"/*; do
        local base_name="$(basename "$theme_file")"
        local dest_file="$theme_dest_dir/$base_name"
        if [ -f "$dest_file" ] && cmp -s "$theme_file" "$dest_file"; then
            print_success "Theme file '$base_name' already exists and is identical. Skipping."
        else
            print_info "Copying theme file '$base_name'..."
            if cp "$theme_file" "$dest_file"; then
                print_success "Theme file '$base_name' copied successfully."
                copied_any=true
            else
                print_error "Failed to copy theme file '$base_name'."
                return 1
            fi
        fi
    done

    if [ "$copied_any" = true ]; then
        print_success "Theme files copy process completed."
    else
        print_info "No theme files needed copying."
    fi
    return 0
}

# Function to update preferences file
update_preferences() {
    print_info "Configuring Warp terminal preferences..."

    # Ensure jq is installed
    if ! command_exists jq; then
        print_info "jq not found. Installing jq for JSON manipulation..."
        if sudo apt install -y jq; then
            print_success "jq installed successfully."
        else
            print_error "Failed to install jq. Cannot configure Warp preferences."
            return 1
        fi
    fi

    # Create config directory if it doesn't exist
    mkdir -p "$(dirname "$PREFS_FILE")" || { print_error "Failed to create preferences directory."; return 1; }

    # Check if the preferences file exists and contains the desired theme configuration
    if [ -f "$PREFS_FILE" ]; then
        if jq -e '.prefs.Theme.Custom.name == "'$THEME_NAME'" and .prefs.Theme.Custom.path == "'$DEFAULT_THEME_PATH'"' "$PREFS_FILE" &> /dev/null; then
            print_success "Warp preferences already configured with $THEME_NAME theme. Skipping update."
            return 0
        else
            print_info "Warp preferences file exists but theme is not configured or is different. Updating..."
        fi
    else
        print_info "Preferences file not found. Creating with default configuration..."
    fi

    # Copy default configuration and update theme path
    if jq --arg theme_name "$THEME_NAME" 
        --arg theme_path "$DEFAULT_THEME_PATH" 
        '.prefs.Theme = {"Custom": {"name": $theme_name, "path": $theme_path}}' 
        "$DEFAULT_CONFIG_FILE" > "$PREFS_FILE"; then
        print_success "Warp preferences configured successfully."
    else
        print_error "Failed to configure Warp preferences."
        return 1
    fi
    return 0
}

# Main script execution
install_warp_terminal || exit 1
copy_themes || exit 1
update_preferences || exit 1

print_success "Warp terminal setup completed successfully."

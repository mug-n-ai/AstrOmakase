#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

# Function to check if a GNOME extension is installed
is_gnome_extension_installed() {
    local extension_id="$1"
    gnome-extensions list | grep -q "^$extension_id$"
}

# Function to install a GNOME extension
install_gnome_extension() {
    local extension_id="$1"
    print_info "Checking if GNOME extension '$extension_id' is installed..."
    if is_gnome_extension_installed "$extension_id"; then
        print_success "GNOME extension '$extension_id' is already installed. Skipping."
    else
        print_info "Installing GNOME extension '$extension_id'..."
        if gext install "$extension_id"; then
            print_success "GNOME extension '$extension_id' installed successfully."
        else
            print_error "Failed to install GNOME extension '$extension_id'."
            return 1
        fi
    fi
    return 0
}

print_title "Installing GNOME extensions..."

# Install gnome-shell-extension-manager
install_package "GNOME Shell Extension Manager" "gnome-shell-extension-manager" "gnome-shell-extension-manager" "apt" "" || exit 1

# Install pipx and gnome-extensions-cli (gext)
print_info "Checking for pipx and gnome-extensions-cli..."
if ! command_exists pipx; then
    print_info "pipx not found. Installing pipx..."
    if apt_install "pipx"; then
        print_success "pipx installed successfully."
    else
        print_error "Failed to install pipx. Cannot install gnome-extensions-cli."
        exit 1
    fi
fi

if ! command_exists gext; then
    print_info "gnome-extensions-cli (gext) not found. Installing via pipx..."
    if pipx install gnome-extensions-cli --system-site-packages; then
        print_success "gnome-extensions-cli (gext) installed successfully."
    else
        print_error "Failed to install gnome-extensions-cli (gext) via pipx."
        exit 1
    fi
else
    print_success "gnome-extensions-cli (gext) is already installed."
fi

# List of GNOME extensions to install
GNOME_EXTENSIONS=(
    "undecorate@sun.wxg@gmail.com"
    "tophat@fflewddur.github.io"
    "AlphabeticalAppGrid@stuarthayhurst"
    "IP-Finder@linxgem33.com"
    "tactile@lundal.io"
    "blur-my-shell@aunetx"
    "space-bar@luchrioh"
)

for ext_id in "${GNOME_EXTENSIONS[@]}"; do
    install_gnome_extension "$ext_id" || true # Continue even if one extension fails
done

# Compile gsettings schemas
print_info "Compiling gsettings schemas..."
local schemas_updated=false

# Define schema files and their target paths
declare -A SCHEMA_FILES
SCHEMA_FILES["tophat@fflewddur.github.io"]="~/.local/share/gnome-shell/extensions/tophat@fflewddur.github.io/schemas/org.gnome.shell.extensions.tophat.gschema.xml"
SCHEMA_FILES["AlphabeticalAppGrid@stuarthayhurst"]="~/.local/share/gnome-shell/extensions/AlphabeticalAppGrid@stuarthayhurst/schemas/org.gnome.shell.extensions.AlphabeticalAppGrid.gschema.xml"
SCHEMA_FILES["tactile@lundal.io"]="~/.local/share/gnome-shell/extensions/tactile@lundal.io/schemas/org.gnome.shell.extensions.tactile.gschema.xml"
SCHEMA_FILES["blur-my-shell@aunetx"]="~/.local/share/gnome-shell/extensions/blur-my-shell@aunetx/schemas/org.gnome.shell.extensions.blur-my-shell.gschema.xml"
SCHEMA_FILES["space-bar@luchrioh"]="~/.local/share/gnome-shell/extensions/space-bar@luchrioh/schemas/org.gnome.shell.extensions.space-bar.gschema.xml"

for ext_id in "${!SCHEMA_FILES[@]}"; do
    local source_schema_path="${SCHEMA_FILES[$ext_id]}"
    source_schema_path="${source_schema_path/#\~/$HOME}" # Expand ~ to $HOME
    local target_schema_path="/usr/share/glib-2.0/schemas/$(basename "$source_schema_path")"

    if [ -f "$source_schema_path" ]; then
        if [ -f "$target_schema_path" ] && cmp -s "$source_schema_path" "$target_schema_path"; then
            print_success "Schema for '$ext_id' is already up-to-date. Skipping copy."
        else
            print_info "Copying schema for '$ext_id' to $target_schema_path..."
            if sudo cp "$source_schema_path" "$target_schema_path"; then
                print_success "Schema for '$ext_id' copied successfully."
                schemas_updated=true
            else
                print_error "Failed to copy schema for '$ext_id'."
            fi
        fi
    else
        print_info "Schema file for '$ext_id' not found at $source_schema_path. Skipping copy."
    fi
done

if [ "$schemas_updated" = true ]; then
    print_info "Running glib-compile-schemas..."
    if sudo glib-compile-schemas /usr/share/glib-2.0/schemas/; then
        print_success "gsettings schemas compiled successfully."
    else
        print_error "Failed to compile gsettings schemas."
    fi
else
    print_success "No schema updates required. Skipping glib-compile-schemas."
fi

print_success "GNOME extensions setup completed successfully."
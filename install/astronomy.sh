#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Astronomy Software..."

install_package "SAO DS9" "ds9" "saods9" "apt" ""
install_package "FITSVerify" "fitsverify" "ftools-fv" "apt" ""
install_package "FTOOLS FV" "ftools-fv" "ftools-fv" "apt" ""
install_package "Stellarium" "stellarium" "stellarium" "apt" ""

# Install Zotero
print_info "Installing Zotero..."
if command_exists zotero; then
    print_success "Zotero is already installed. Skipping."
else
    print_info "Zotero not found. Running Zotero installation script..."
    if curl -sL https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash; then
        print_success "Zotero installed successfully."
    else
        print_error "Failed to install Zotero. Please check the output above for details."
        exit 1
    fi
fi

# Install Zotero Connector for Chrome
print_info "Installing Zotero Connector for Chrome..."

# Ensure jq and unzip are installed
install_package "jq" "jq" "jq" "apt" "" || { print_error "jq is required for Zotero Connector installation."; exit 1; }
install_package "unzip" "unzip" "unzip" "apt" "" || { print_error "unzip is required for Zotero Connector installation."; exit 1; }

local extension_url="https://clients2.google.com/service/update2/crx?response=redirect&prodversion=91.0.4472.124&x=id%3Dekhagklcjbdpajgpjgmbionohlpdbjgc%26installsource%3Dondemand%26uc"
local download_path="/tmp/zotero_connector.crx"
local chrome_extensions_dir="$HOME/.config/google-chrome/Default/Extensions"
local extension_id="ekhagklcjbdpajgpjgmbionohlpdbjgc"
local zotero_connector_install_dir="$chrome_extensions_dir/zotero_connector"
local preferences_file="$HOME/.config/google-chrome/Default/Preferences"

# Check if the Zotero Connector is already installed (by checking its directory)
if [ -d "$zotero_connector_install_dir" ]; then
    print_success "Zotero Connector appears to be already installed. Skipping installation."
else
    print_info "Zotero Connector not found. Proceeding with installation."

    print_info "Downloading Zotero Connector extension..."
    if [ -f "$download_path" ]; then
        print_success "Zotero Connector CRX already exists. Skipping download."
    else
        if ! wget -O "$download_path" "$extension_url"; then
            print_error "Failed to download the Zotero Connector extension."
            exit 1
        fi
        print_success "Zotero Connector downloaded successfully."
    fi

    print_info "Installing Zotero Connector..."
    mkdir -p "$chrome_extensions_dir" || { print_error "Failed to create Chrome extensions directory."; exit 1; }

    if unzip -q "$download_path" -d "$zotero_connector_install_dir"; then
        print_success "Zotero Connector unzipped successfully."
    else
        print_error "Failed to unzip Zotero Connector. Exiting."
        exit 1
    fi

    # Enable Developer Mode in Chrome (required for manually installed extensions)
    # This part is tricky for idempotency and might require user intervention or a more robust jq operation.
    # For now, we'll attempt to modify the preferences file.
    print_info "Attempting to enable Developer Mode for Zotero Connector in Chrome preferences..."
    if [ -f "$preferences_file" ]; then
        if jq '.extensions.settings."'"$extension_id"'" = {"installation_mode": "developer"}' "$preferences_file" > "$preferences_file.tmp" && mv "$preferences_file.tmp" "$preferences_file"; then
            print_success "Chrome preferences updated for Zotero Connector. You may need to restart Chrome."
        else
            print_error "Failed to update Chrome preferences for Zotero Connector. You may need to enable it manually."
        fi
    else
        print_error "Chrome preferences file not found at $preferences_file. Cannot automatically enable Zotero Connector."
    fi

    print_info "Cleaning up temporary files..."
    if rm "$download_path"; then
        print_success "Temporary files removed successfully."
    else
        print_error "Failed to remove temporary files."
    fi

    print_success "Zotero Connector installation process completed. Please enable it in your Chrome extensions settings if it's not active."
fi

#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"


install_package "SAO DS9" "ds9" "saods9" "apt" "None"

install_package "FITSVerify" "fitsverify" "ftools-fv" "apt" "None"

install_package "FTOOLS FV" "ftools-fv" "ftools-fv" "apt" "None"

install_package "Stellarium" "stellarium" "stellarium" "apt" "None"

echo "Installing Zotero..."
if command_exists zotero; then
    print_success "Zotero is already installed. Skipping."
else
    curl -sL https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
    if [ $? -ne 0 ]; then
        print_error "Failed to install Zotero. Exiting."
        exit 1
    fi
    print_success "Zotero installed successfully."
fi


echo "Installing Zotero Connector for Chrome..."
# URL of the Zotero Connector extension CRX file
extension_url="https://clients2.google.com/service/update2/crx?response=redirect&prodversion=91.0.4472.124&x=id%3Dekhagklcjbdpajgpjgmbionohlpdbjgc%26installsource%3Dondemand%26uc"

# Path where the extension will be downloaded
download_path="/tmp/zotero_connector.crx"

# Path where Chrome stores extensions
chrome_extensions_dir="$HOME/.config/google-chrome/Default/Extensions"

# Function to check if the Zotero Connector is already installed
is_extension_installed() {
    if [ -d "$chrome_extensions_dir/$extension_id" ]; then
        return 0 # Extension is installed
    else
        return 1 # Extension is not installed
    fi
}

# Check if Zotero Connector is already installed
if is_extension_installed; then
    echo "Zotero Connector is already installed."
else
    # Download the Zotero Connector CRX file
    echo "Downloading Zotero Connector extension..."
    wget -O "$download_path" "$extension_url"

    # Verify the download
    if [ -f "$download_path" ]; then
        echo "Download completed."
    else
        echo "Failed to download the extension."
        exit 1
    fi

    # Create a directory for manual extensions if it doesn't exist
    mkdir -p "$chrome_extensions_dir"

    # Move the extension to the Chrome extensions directory
    echo "Installing Zotero Connector..."
    unzip -q "$download_path" -d "$chrome_extensions_dir/zotero_connector"

    # Enable Developer Mode in Chrome (required for manually installed extensions)
    preferences="$HOME/.config/google-chrome/Default/Preferences"
    jq '.extensions.settings."ekhagklcjbdpajgpjgmbionohlpdbjgc" = {"installation_mode": "developer"}' "$preferences" > "$preferences.tmp" && mv "$preferences.tmp" "$preferences"

    # Clean up
    rm "$download_path"

    echo "Zotero Connector installed successfully. Please enable it in the Chrome extensions settings."

fi

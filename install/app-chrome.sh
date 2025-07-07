#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Google Chrome..."

echo "Checking if Google Chrome is already installed..."
if command_exists google-chrome; then
    print_success "Google Chrome is already installed. Exiting script."
    exit 0
fi

echo "Downloading Google Chrome..."
wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
print_success "Google Chrome downloaded successfully."

apt_install /tmp/chrome.deb

echo "Removing temporary files..."
rm /tmp/chrome.deb
print_success "Temporary files removed successfully."

echo "Setting Google Chrome as the default web browser..."
xdg-settings set default-web-browser google-chrome.desktop
print_success "Google Chrome set as the default web browser."

apt_install gnome-browser-connector

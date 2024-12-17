#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"


print_title "Setting default applications..."

echo "Setting default applications for office fles types..."
# set onlyoffice as default for office files
xdg-mime default onlyoffice-desktopeditors_onlyoffice-desktopeditors.desktop application/vnd.openxmlformats-officedocument.wordprocessingml.document
xdg-mime default onlyoffice-desktopeditors_onlyoffice-desktopeditors.desktop application/vnd.openxmlformats-officedocument.spreadsheetml.sheet
xdg-mime default onlyoffice-desktopeditors_onlyoffice-desktopeditors.desktop application/vnd.openxmlformats-officedocument.presentationml.presentation
xdg-mime default onlyoffice-desktopeditors_onlyoffice-desktopeditors.desktop text/csv


echo "Setting default browser..."
# set Chrome as default web browser
xdg-settings set default-web-browser google-chrome.desktop

echo "Setting default applications for text file types..."
# set Zed editor as default for text file types
xdg-mime default zed.desktop text/plain
xdg-mime default zed.desktop text/x-python
xdg-mime default zed.desktop application/octet-stream
xdg-mime default zed.desktop text/x-shellscript
xdg-mime default zed.desktop text/x-log
xdg-mime default zed.desktop text/xml
xdg-mime default zed.desktop application/xml
xdg-mime default zed.desktop text/x-yaml
xdg-mime default zed.desktop application/x-yaml
xdg-mime default zed.desktop text/x-csrc
xdg-mime default zed.desktop text/x-chdr
xdg-mime default zed.desktop text/x-c++
xdg-mime default zed.desktop text/x-c++hdr
xdg-mime default zed.desktop text/x-c++src
xdg-mime default zed.desktop text/markdown
xdg-mime default zed.desktop application/json
xdg-mime default zed.desktop text/x-ini
xdg-mime default zed.desktop text/x-config

print_success "Default applications set successfully."
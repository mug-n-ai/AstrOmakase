#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Installing qBittorrent..."
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt-get update && sudo apt-get install -y qbittorrent
if [ $? -ne 0 ]; then
    print_error "Failed to install qBittorrent. Exiting."
    exit 1
fi
print_success "qBittorrent installed successfully."

#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Installing qBittorrent..."
sudo add-apt-repository ppa:qbittorrent-team/qbittorrent-stable
sudo apt-get update

apt_install qbittorrent

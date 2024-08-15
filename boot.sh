#!/bin/bash

# AstrOmakase bootstrapper is inspired by the Omakase project by Basecamp.

get_latest_release() {
    curl --silent "https://api.github.com/repos/LorenzoMugnai/AstrOmakase/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'
}


set -e

echo "AstrOmakase bootstrapper"
echo "=> AstrOmakase is for fresh Ubuntu 24.04 installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

echo "Installing git..."
sudo apt-get update
sudo apt-get install -y git >/dev/null

echo "Cloning stable AstrOmakase..."
rm -rf ~/.local/share/astromakase
git clone https://github.com/LorenzoMugnai/AstrOmakase.git ~/.local/share/astromakase >/dev/null

LATEST_RELEASE=$(get_latest_release)

echo "Latest release: $LATEST_RELEASE"
if [ -z "$LATEST_RELEASE" ]; then
    echo "Impossible to find latest release. Exiting."
    exit 1
fi

git -c advice.detachedHead=false checkout "tags/$LATEST_RELEASE" >/dev/null

echo "Installation starting..."
source ~/.local/share/astromakase/install.sh

# Logout to pickup changes
gum confirm "Ready to logout for all settings to take effect?" && gnome-session-quit --logout --no-prompt

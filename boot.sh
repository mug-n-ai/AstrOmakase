#!/bin/bash

# AstrOmakase bootstrapper is inspired by the Omakase project by Basecamp.

get_latest_release() {
    curl --silent "https://api.github.com/repos/LorenzoMugnai/AstrOmakase/releases/latest" |
    grep '"tag_name":' |
    sed -E 's/.*"([^"]+)".*/\1/'
}


set -e

#Initial Message
echo "========================================="
echo "   Welcome to the AstrOmakase Installer    "
echo "========================================="
echo "This script will guide you through the installation of AstrOmakase on your Ubuntu 24.04 system."
echo "If Omakub is not detected, you will have the option to install it for an enhanced experience."
echo "\nBegin installation (or abort with Ctrl+C)...\n"

INSTALL_DIR=~/.local/share/astromakase

if [ ! -d "$INSTALL_DIR" ]; then
    echo "=> AstrOmakase is for fresh Ubuntu 24.04 installations only!"
fi

echo "Installing git..."
sudo apt-get install -y git >/dev/null

# Save the current version if it exists, to a temporary location
if [ -f ~/.local/share/astromakase/version ]; then
    echo "Saving the current version..."
    mv ~/.local/share/astromakase/version /tmp/version_previous
fi

echo "Cloning stable AstrOmakase..."
rm -rf $INSTALL_DIR
git clone https://github.com/LorenzoMugnai/AstrOmakase.git $INSTALL_DIR >/dev/null

# Restore the previous version file to the new directory, if it was saved
if [ -f /tmp/version_previous ]; then
    mv /tmp/version_previous ~/.local/share/astromakase/version_previous
    echo "Previous version restored."
fi

cd $INSTALL_DIR
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
if gum confirm "Ready to logout for all settings to take effect?"; then
    gnome-session-quit --logout --no-prompt
else
    echo "Logout cancelled. You can log out later for changes to take effect."
fi
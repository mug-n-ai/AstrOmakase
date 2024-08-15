#!/bin/bash

# AstrOmakase bootstrapper is inspired by the Omakase project by Basecamp.

set -e

echo "AstrOmakase bootstrapper"
echo "=> AstrOmakase is for fresh Ubuntu 24.04 installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning stable AstrOmakase..."
rm -rf ~/.local/share/astromakase
git clone https://github.com/LorenzoMugnai/AstrOmakase.git ~/.local/share/astromakase >/dev/null

echo "Installation starting..."
source ~/.local/share/astromakase/install.sh

# Logout to pickup changes
gum confirm "Ready to logout for all settings to take effect?" && gnome-session-quit --logout --no-prompt

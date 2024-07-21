#!/bin/bash

# AstrOmakase bootstrapper is inspired by the Omakase project by Basecamp.

set -e

ascii_art='AstrOmakase'

echo -e "$ascii_art"
echo "=> AstrOmakase is for fresh Ubuntu 24.04 installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."


sudo apt-get update >/dev/null
sudo apt-get install -y git >/dev/null

echo "Cloning stable AstrOmakase..."
rm -rf ~/.local/share/astromakase
git clone -b stable https://github.com/basecamp/omakub.git ~/.local/share/astromakase >/dev/null

echo "Installation starting..."
source ~/.local/share/astromakase/install.sh

#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

if command_exists fastfetch; then
    print_success "fastfetch is already installed. Exiting script."
else
    # add repository
    sudo add-apt-repository -y ppa:zhangsongcui3371/fastfetch
    sudo apt update -y
    apt_install fastfetch
fi

echo "Setting up FastFetch..."

if [ -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  gum confirm "It appears that a fastfetch configuration is already set. Do you want to overwrite it?" && rm "$HOME/.config/fastfetch/config.jsonc"
fi

if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  mkdir -p ~/.config/fastfetch
  cp $INSTALL_DIR/config/fastfetch/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
fi


install_package "okular" "okular" "okular" "snap" "None"

install_package "screen" "screen" "screen" "apt" "None"

install_package "htop" "htop" "htop" "apt" "None"

install_package "btop" "btop" "btop" "apt" "None"

install_package "eza" "eza" "eza" "apt" "None"

install_package "fd-find" "fd" "fd-find" "apt" "None"

install_package "plocate" "plocate" "plocate" "apt" "None"

install_package "zoxide" "zoxide" "zoxide" "apt" "None"

install_package "nmap" "nmap" "nmap" "apt" "None"

install_package "pavucontrol" "pavucontrol" "pavucontrol" "apt" "None"


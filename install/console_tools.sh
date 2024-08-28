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

apt_install screen

apt_install htop

apt_install btop

apt_install eza

apt_install fd-find

apt_install plocate

apt_install zoxide

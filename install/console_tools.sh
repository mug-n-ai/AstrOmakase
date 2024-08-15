#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

apt_install screen

apt_install htop

apt_install btop

apt_install eza

apt_install fd-find

apt_install plocate

apt_install zoxide

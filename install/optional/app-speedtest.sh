#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"

echo "Checking for curl installation..."
if ! command -v curl &> /dev/null; then
    echo "curl is not installed. Installing curl..."
    sudo apt update
    sudo apt install -y curl
    if [ $? -ne 0 ]; then
        print_error "Failed to install curl. Exiting."
        exit 1
    fi
    print_success "curl installed successfully."
else
    print_success "curl is already installed."
fi

echo "Installing Speedtest CLI..."
curl -s https://packagecloud.io/install/repositories/ookla/speedtest-cli/script.deb.sh | sudo bash
if [ $? -ne 0 ]; then
    print_error "Failed to add Speedtest CLI repository. Exiting."
    exit 1
fi

apt_install speedtest-cli

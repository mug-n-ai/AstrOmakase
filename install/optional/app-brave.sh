#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Brave..."

if command_exists brave-browser; then
    print_success "Brave is already installed. Skipping installation."
else
    print_info "Brave not found. Proceeding with installation."

    local repo_added=false

    # Add Brave GPG key
    print_info "Adding Brave Browser GPG key..."
    if [ ! -f /usr/share/keyrings/brave-browser-archive-keyring.gpg ]; then
        if sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg; then
            print_success "Brave Browser GPG key added."
            repo_added=true
        else
            print_error "Failed to add Brave Browser GPG key."
            exit 1
        fi
    else
        print_success "Brave Browser GPG key already exists."
    fi

    # Add Brave repository
    print_info "Adding Brave Browser repository..."
    if [ ! -f /etc/apt/sources.list.d/brave-browser-release.list ]; then
        if echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list > /dev/null; then
            print_success "Brave Browser repository added."
            repo_added=true
        else
            print_error "Failed to add Brave Browser repository."
            exit 1
        fi
    else
        print_success "Brave Browser repository already exists."
    fi

    if [ "$repo_added" = true ]; then
        print_info "Updating apt package list after adding new repository..."
        if sudo apt update -y; then
            print_success "Apt package list updated."
        else
            print_error "Failed to update apt package list."
            exit 1
        fi
    fi

    install_package "Brave Browser" "brave-browser" "brave-browser" "apt" ""
fi

#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Google Chrome..."

print_info "Checking if Google Chrome is already installed..."
if command_exists google-chrome; then
    print_success "Google Chrome is already installed. Skipping installation."
else
    print_info "Google Chrome not found. Proceeding with installation."

    print_info "Downloading Google Chrome..."
    if wget -O /tmp/chrome.deb https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb; then
        print_success "Google Chrome downloaded successfully."
    else
        print_error "Failed to download Google Chrome."
        exit 1
    fi

    print_info "Installing Google Chrome .deb package..."
    if sudo dpkg -i /tmp/chrome.deb; then
        print_success "Google Chrome .deb package installed successfully."
    else
        print_error "Failed to install Google Chrome .deb package. Attempting to fix broken dependencies..."
        if sudo apt --fix-broken install -y; then
            print_success "Fixed broken dependencies. Retrying Google Chrome .deb package installation..."
            if sudo dpkg -i /tmp/chrome.deb; then
                print_success "Google Chrome .deb package installed successfully after fixing dependencies."
            else
                print_error "Failed to install Google Chrome .deb package even after fixing dependencies."
                exit 1
            fi
        else
            print_error "Failed to fix broken dependencies. Google Chrome installation failed."
            exit 1
        fi
    fi

    print_info "Removing temporary files..."
    if rm /tmp/chrome.deb; then
        print_success "Temporary files removed successfully."
    else
        print_error "Failed to remove temporary files."
    fi
fi

print_info "Setting Google Chrome as the default web browser..."
if xdg-settings set default-web-browser google-chrome.desktop; then
    print_success "Google Chrome set as the default web browser."
else
    print_error "Failed to set Google Chrome as the default web browser."
fi

# Use the common install_package function for gnome-browser-connector
install_package "GNOME Browser Connector" "gnome-browser-connector" "gnome-browser-connector" "apt" ""

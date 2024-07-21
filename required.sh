#!/bin/bash

source "$INSTALL_DIR/common_functions.sh"

# Check if gum is installed
if ! command_exists gum; then
    echo "gum is not installed. Installing gum..."

    # Ensure snapd is installed
    if ! command_exists snap; then
        echo "snap is not installed. Installing snap..."
        sudo apt update
        sudo apt install -y snapd
        if [ $? -ne 0 ]; then
            print_error "Failed to install snap. Exiting."
            exit 1
        fi
        print_success "snap installed successfully."
    fi

    # Install gum using snap
    sudo snap install gum
    if [ $? -ne 0 ]; then
        print_error "Failed to install gum. Exiting."
        exit 1
    fi
    print_success "gum installed successfully."
else
    print_success "gum is already installed."
fi

echo "Checking for Flatpak installation..."
if ! command_exists flatpak; then
    echo "Flatpak is not installed. Installing Flatpak..."
    sudo apt install -y flatpak
    if [ $? -ne 0 ]; then
        print_error "Failed to install Flatpak. Exiting."
        exit 1
    fi
    print_success "Flatpak installed successfully."
else
    print_success "Flatpak is already installed."
fi

echo "Adding Flathub repository to Flatpak..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
if [ $? -ne 0 ]; then
    print_error "Failed to add Flathub repository. Exiting."
    exit 1
fi
print_success "Flathub repository added successfully."

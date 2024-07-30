#!/bin/bash

# Function to print error messages
print_error() {
    echo "[ERROR] $1" >&2
}

# Function to print success messages
print_success() {
    echo "[SUCCESS] $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}


apt_install() {
    sudo apt install -y "$1"
    if [ $? -ne 0 ]; then
        print_error "Failed to install $1. Exiting."
        exit 1
    fi
    print_success "$1 installed successfully."
}

snap_install() {
    sudo snap install "$1"
    if [ $? -ne 0 ]; then
        print_error "Failed to install $1 via Snap. Exiting."
        exit 1
    fi
    print_success "$1 installed successfully via Snap."
}

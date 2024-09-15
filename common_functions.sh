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

install_package() {
    # $1: Name of the package
    # $2: Name of the package as it appears in dpkg -l
    # $3: Name of the package as it appears in apt or snap
    # $4: Package manager (apt or snap)
    echo "Checking if $1 is already installed..."
    if command_exists "$2"; then
        print_success ""$1" is already installed. Exiting script."

    else
        if [ "$5" != "None" ]; then
            echo "Installing dependencies..."
            for dep in $5; do
                apt_install "$dep"
            done
        fi

        echo "Installing $1..."
        if [ "$4" = "apt" ]; then
            apt_install "$3"
        else
            if [ "$4" = "snap" ]; then
                snap_install "$3"
            else
                print_error "Invalid package manager. Exiting."
                exit 1
            fi
        fi
    fi

    print_success "$1 setup completed successfully."

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

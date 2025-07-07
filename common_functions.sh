#!/bin/bash
set -e

# Function to print error messages
print_error() {
    echo -e "\033[0;31m[ERROR]\033[0m $1" >&2
}

# Function to print success messages
print_success() {
    echo -e "\033[0;32m[SUCCESS]\033[0m $1"
}

print_title() {
    echo -e "\033[1;34m$1\033[0m"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}

install_package() {
    local display_name="$1" # Name for display purposes (e.g., "Google Chrome")
    local check_command="$2" # Command to check if installed (e.g., "google-chrome")
    local install_name="$3" # Name for apt/snap install (e.g., "google-chrome-stable")
    local package_manager="$4" # "apt" or "snap"
    local -n dependencies_array="$5" # Array of dependencies

    echo "Attempting to install $display_name..."

    # Check if already installed using the provided check_command
    if command_exists "$check_command"; then
        print_success "'$display_name' is already installed."
        return 0
    fi

    if [ ${#dependencies_array[@]} -gt 0 ]; then
        echo "Installing dependencies for $display_name..."
        for dep in "${dependencies_array[@]}"; do
            apt_install "$dep"
        done
    fi

    echo "Installing $display_name..."
    if [ "$package_manager" = "apt" ]; then
        apt_install "$install_name"
    elif [ "$package_manager" = "snap" ]; then
        snap_install "$install_name"
    else
        print_error "Invalid package manager specified for $display_name. Exiting."
        exit 1
    fi

    print_success "$display_name setup completed successfully."
}

apt_install() {
    local package_name="$1"
    if dpkg -s "$package_name" &> /dev/null; then
        print_success "'$package_name' is already installed."
        return 0
    fi

    echo "Installing '$package_name' via apt..."
    sudo apt install -y "$package_name"
    print_success "'$package_name' installed successfully."
}

snap_install() {
    local package_name="$1"
    if snap list | grep -q "^$package_name\s"; then
        print_success "'$package_name' is already installed via Snap."
        return 0
    fi

    echo "Installing '$package_name' via Snap..."
    sudo snap install "$package_name"
    print_success "'$package_name' installed successfully via Snap."
}

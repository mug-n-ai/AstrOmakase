#!/bin/bash
set -euo pipefail

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

# Function to install a package via apt
apt_install() {
    local package_name="$1"
    if dpkg -s "$package_name" &> /dev/null; then
        print_success "'$package_name' is already installed via apt. Skipping."
        return 0
    fi

    print_info "Installing '$package_name' via apt..."
    if sudo apt install -y "$package_name"; then
        print_success "'$package_name' installed successfully via apt."
    else
        print_error "Failed to install '$package_name' via apt."
        return 1
    fi
}

# Function to install a package via snap
snap_install() {
    local package_name="$1"
    if snap list | grep -q "^$package_name\s"; then
        print_success "'$package_name' is already installed via Snap. Skipping."
        return 0
    fi

    print_info "Installing '$package_name' via Snap..."
    if sudo snap install "$package_name"; then
        print_success "'$package_name' installed successfully via Snap."
    else
        print_error "Failed to install '$package_name' via Snap."
        return 1
    fi
}

# Function to install a package (main entry point)
install_package() {
    local display_name="$1" # Name for display purposes (e.g., "Google Chrome")
    local check_command="$2" # Command to check if installed (e.g., "google-chrome")
    local install_name="$3" # Name for apt/snap install (e.g., "google-chrome-stable")
    local package_manager="$4" # "apt" or "snap"
    local -n dependencies_array="$5" # Array of dependencies

    print_info "Attempting to install $display_name..."

    # Check if already installed using the provided check_command
    if command_exists "$check_command"; then
        print_success "'$display_name' is already installed (command check)."
        return 0
    fi

    if [ ${#dependencies_array[@]} -gt 0 ]; then
        print_info "Installing dependencies for $display_name..."
        for dep in "${dependencies_array[@]}"; do
            apt_install "$dep" || { print_error "Dependency $dep failed to install."; return 1; }
        done
    fi

    print_info "Proceeding with $display_name installation..."
    if [ "$package_manager" = "apt" ]; then
        apt_install "$install_name"
    elif [ "$package_manager" = "snap" ]; then
        snap_install "$install_name"
    else
        print_error "Invalid package manager specified for $display_name. Must be 'apt' or 'snap'."
        return 1
    fi

    # Re-check after installation attempt
    if command_exists "$check_command"; then
        print_success "$display_name setup completed successfully."
    else
        print_error "$display_name installation failed or command not found after installation."
        return 1
    fi
}

# Function to print informational messages
print_info() {
    echo -e "\033[0;36m[INFO]\033[0m $1"
}

# Function to set gsettings key idempotently
set_gsetting_idempotent() {
    local schema="$1"
    local key="$2"
    local value="$3"
    local display_name="$4"

    local current_value
    current_value=$(gsettings get "$schema" "$key" 2>/dev/null || true)

    # Remove quotes from current_value if it's a string
    current_value=$(echo "$current_value" | sed "s/^'\(.*\)'$/\1/")

    if [ "$current_value" = "$value" ]; then
        print_success "Gnome setting '$display_name' is already set to '$value'. Skipping."
    else
        print_info "Setting Gnome setting '$display_name' to '$value'..."
        if gsettings set "$schema" "$key" "$value"; then
            print_success "Gnome setting '$display_name' set successfully."
        else
            print_error "Failed to set Gnome setting '$display_name' to '$value'."
            return 1
        fi
    fi
    return 0
}


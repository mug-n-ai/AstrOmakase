#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Console Tools..."

# Function to add apt repository idempotently (copied from app-ulauncher.sh for reusability)
_add_apt_repository_idempotent() {
    local repo_name="$1"
    print_info "Checking if repository '$repo_name' is already added..."
    if grep -q "^deb .*$repo_name" /etc/apt/sources.list /etc/apt/sources.list.d/*; then
        print_success "Repository '$repo_name' already added. Skipping."
        return 0
    else
        print_info "Adding repository '$repo_name'..."
        if sudo add-apt-repository -y "$repo_name"; then
            print_success "Repository '$repo_name' added successfully."
            return 0
        else
            print_error "Failed to add repository '$repo_name'."
            return 1
        fi
    fi
}

# Install fastfetch
print_info "Installing fastfetch..."
repo_added_for_fastfetch=false
if _add_apt_repository_idempotent "ppa:zhangsongcui3371/fastfetch"; then
    repo_added_for_fastfetch=true
fi

if [ "$repo_added_for_fastfetch" = true ]; then
    print_info "Updating apt package list after adding new repository..."
    if sudo apt update -y; then
        print_success "Apt package list updated."
    else
        print_error "Failed to update apt package list."
        exit 1
    fi
fi
install_package "fastfetch" "fastfetch" "fastfetch" "apt" ""

# Set up FastFetch configuration
print_info "Setting up FastFetch configuration..."
local fastfetch_config_dir="$HOME/.config/fastfetch"
local fastfetch_config_file="$fastfetch_config_dir/config.jsonc"
local astromakase_fastfetch_config="$SCRIPT_DIR/../settings/config/fastfetch/fastfetch.jsonc"

if [ ! -d "$fastfetch_config_dir" ]; then
    print_info "Creating fastfetch config directory: $fastfetch_config_dir"
    if mkdir -p "$fastfetch_config_dir"; then
        print_success "Fastfetch config directory created."
    else
        print_error "Failed to create fastfetch config directory."
    fi
fi

if [ -f "$astromakase_fastfetch_config" ]; then
    if [ -f "$fastfetch_config_file" ] && cmp -s "$astromakase_fastfetch_config" "$fastfetch_config_file"; then
        print_success "Fastfetch configuration already up-to-date. Skipping copy."
    else
        if gum confirm "It appears that a fastfetch configuration is already set or different. Do you want to overwrite it with the Astromakase default?"; then
            print_info "Copying Astromakase fastfetch configuration to $fastfetch_config_file..."
            if cp "$astromakase_fastfetch_config" "$fastfetch_config_file"; then
                print_success "Fastfetch configuration copied successfully."
            else
                print_error "Failed to copy fastfetch configuration."
            fi
        else
            print_info "Skipped overwriting fastfetch configuration."
        fi
    fi
else
    print_error "Astromakase fastfetch configuration file not found at $astromakase_fastfetch_config. Skipping config copy."
fi

# Install other console tools
install_package "Okular" "okular" "okular" "snap" ""
install_package "screen" "screen" "screen" "apt" ""
install_package "htop" "htop" "htop" "apt" ""
install_package "btop" "btop" "btop" "apt" ""
install_package "eza" "eza" "eza" "apt" ""
install_package "fd-find" "fd" "fd-find" "apt" ""
install_package "plocate" "plocate" "plocate" "apt" ""
install_package "zoxide" "zoxide" "zoxide" "apt" ""
install_package "nmap" "nmap" "nmap" "apt" ""
install_package "pavucontrol" "pavucontrol" "pavucontrol" "apt" ""

print_success "Console Tools setup completed successfully."


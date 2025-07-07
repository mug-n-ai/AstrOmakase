#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing GitHub CLI..."

_install_github_cli() {
    print_info "Checking if GitHub CLI is already installed..."
    if command_exists gh; then
        print_success "GitHub CLI is already installed. Skipping installation."
        return 0
    fi

    print_info "GitHub CLI not found. Proceeding with installation."

    local repo_added=false

    # Check and install wget if not present
    if ! command_exists wget; then
        print_info "wget not found. Installing wget..."
        if sudo apt update && sudo apt install -y wget; then
            print_success "wget installed successfully."
        else
            print_error "Failed to install wget. Cannot proceed with GitHub CLI installation."
            return 1
        fi
    fi

    # Add GPG key
    print_info "Adding GitHub CLI GPG key..."
    if [ ! -f /etc/apt/keyrings/githubcli-archive-keyring.gpg ]; then
        if sudo mkdir -p -m 755 /etc/apt/keyrings && \
           wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg > /dev/null && \
           sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg; then
            print_success "GitHub CLI GPG key added."
            repo_added=true
        else
            print_error "Failed to add GitHub CLI GPG key."
            return 1
        fi
    else
        print_success "GitHub CLI GPG key already exists."
    fi

    # Add GitHub CLI repository
    print_info "Adding GitHub CLI repository..."
    if [ ! -f /etc/apt/sources.list.d/github-cli.list ]; then
        if echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list > /dev/null; then
            print_success "GitHub CLI repository added."
            repo_added=true
        else
            print_error "Failed to add GitHub CLI repository."
            return 1
        fi
    else
        print_success "GitHub CLI repository already exists."
    fi

    if [ "$repo_added" = true ]; then
        print_info "Updating apt package list after adding new repository..."
        if sudo apt update; then
            print_success "Apt package list updated."
        else
            print_error "Failed to update apt package list."
            return 1
        fi
    fi

    # Install gh package
    print_info "Installing gh package..."
    if sudo apt install -y gh; then
        print_success "gh package installed successfully."
    else
        print_error "Failed to install gh package."
        return 1
    fi

    print_success "GitHub CLI setup completed successfully."
    return 0
}

_install_github_cli

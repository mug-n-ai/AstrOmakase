#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Docker and Lazydocker..."

_install_docker_engine() {
    print_info "Checking for Docker Engine installation..."
    if command_exists docker; then
        print_success "Docker Engine is already installed."
    else
        print_info "Docker Engine not found. Proceeding with installation."

        # Add the official Docker repo
        print_info "Adding Docker GPG key and repository..."
        if sudo install -m 0755 -d /etc/apt/keyrings && \
           sudo wget -qO /etc/apt/keyrings/docker.asc https://download.docker.com/linux/ubuntu/gpg && \
           sudo chmod a+r /etc/apt/keyrings/docker.asc && \
           echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null; then
            print_success "Docker GPG key and repository added."
        else
            print_error "Failed to add Docker GPG key and repository."
            return 1
        fi

        print_info "Updating apt package index..."
        if sudo apt update; then
            print_success "Apt package index updated."
        else
            print_error "Failed to update apt package index."
            return 1
        fi

        # Install Docker engine and standard plugins
        print_info "Installing Docker Engine and standard plugins..."
        if sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin docker-ce-rootless-extras; then
            print_success "Docker Engine and standard plugins installed."
        else
            print_error "Failed to install Docker Engine and standard plugins."
            return 1
        fi
    fi

    # Give this user privileged Docker access
    print_info "Checking Docker group membership for user '${USER}'..."
    if id -nG "${USER}" | grep -qw "docker"; then
        print_success "User '${USER}' is already in the 'docker' group."
    else
        print_info "Adding user '${USER}' to the 'docker' group..."
        if sudo usermod -aG docker "${USER}"; then
            print_success "User '${USER}' added to 'docker' group. Please log out and back in for changes to take effect."
        else
            print_error "Failed to add user '${USER}' to the 'docker' group."
            return 1
        fi
    fi

    # Limit log size to avoid running out of disk
    print_info "Checking Docker daemon log configuration..."
    if grep -q '"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}' /etc/docker/daemon.json 2>/dev/null; then
        print_success "Docker daemon log configuration already set."
    else
        print_info "Setting Docker daemon log size limit..."
        if echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json > /dev/null; then
            print_success "Docker daemon log size limit set."
        else
            print_error "Failed to set Docker daemon log size limit."
            return 1
        fi
    fi
}

_install_lazydocker() {
    print_info "Checking for Lazydocker installation..."
    if command_exists lazydocker; then
        print_success "Lazydocker is already installed."
        return 0
    fi

    print_info "Lazydocker not found. Proceeding with installation."
    (cd /tmp || { print_error "Failed to change directory to /tmp."; return 1; }
    LAZYDOCKER_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
    if [ -z "$LAZYDOCKER_VERSION" ]; then
        print_error "Failed to retrieve Lazydocker version."
        return 1
    fi

    print_info "Downloading Lazydocker v${LAZYDOCKER_VERSION}..."
    if curl -sLo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VERSION}_Linux_x86_64.tar.gz"; then
        print_success "Lazydocker downloaded."
    else
        print_error "Failed to download Lazydocker."
        return 1
    fi

    print_info "Extracting Lazydocker..."
    if tar -xf lazydocker.tar.gz lazydocker; then
        print_success "Lazydocker extracted."
    else
        print_error "Failed to extract Lazydocker."
        return 1
    fi

    print_info "Installing Lazydocker to /usr/local/bin..."
    if sudo install lazydocker /usr/local/bin; then
        print_success "Lazydocker installed successfully."
    else
        print_error "Failed to install Lazydocker."
        return 1
    fi

    print_info "Cleaning up temporary files..."
    if rm lazydocker.tar.gz lazydocker; then
        print_success "Temporary files cleaned up."
    else
        print_error "Failed to clean up temporary files."
    fi
    )
}

_install_docker_engine || exit 1
_install_lazydocker || exit 1

print_success "Docker and Lazydocker setup completed."


#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Ulauncher..."

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

repo_added=false
if _add_apt_repository_idempotent "universe"; then
    repo_added=true
fi

if _add_apt_repository_idempotent "ppa:agornostal/ulauncher"; then
    repo_added=true
fi

if [ "$repo_added" = true ]; then
    print_info "Updating apt package list after adding new repositories..."
    if sudo apt update -y; then
        print_success "Apt package list updated."
    else
        print_error "Failed to update apt package list."
        exit 1
    fi
fi

install_package "Ulauncher" "ulauncher" "ulauncher" "apt" ""



#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Migrating from 0.2.2..."

# Migrate Okular from apt to snap
print_info "Checking Okular installation for migration..."
if dpkg -s okular &> /dev/null; then
    print_info "Okular is installed via apt. Migrating to snap..."
    if sudo apt purge -y okular; then
        print_success "Okular apt package purged successfully."
        if sudo apt autoremove -y; then
            print_success "Unused apt packages removed."
        else
            print_error "Failed to autoremove unused apt packages."
        fi
    else
        print_error "Failed to purge Okular apt package. Skipping snap installation."
        exit 1
    fi
else
    print_success "Okular apt package not found. Assuming already migrated or not installed via apt."
fi

# Ensure Okular is installed via snap using the common function
install_package "Okular" "okular" "okular" "snap" "" || exit 1

print_success "Migration from 0.2.2 complete."

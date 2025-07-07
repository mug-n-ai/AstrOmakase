#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing pre-commit..."

if command_exists pre-commit; then
    print_success "pre-commit is already installed. Skipping installation."
    exit 0
fi

print_info "pre-commit not found. Attempting to install..."

if command_exists conda; then
    print_info "Conda detected. Attempting to install pre-commit into the base conda environment."
    if conda run -n base pip install pre-commit; then
        print_success "pre-commit installed successfully via conda pip."
    else
        print_error "Failed to install pre-commit via conda pip. Attempting global pip install as fallback."
        if pip install pre-commit; then
            print_success "pre-commit installed successfully via global pip."
        else
            print_error "Failed to install pre-commit via global pip. Please check your Python/pip setup."
            exit 1
        fi
    fi
else
    print_info "Conda not detected. Attempting to install pre-commit via global pip."
    if pip install pre-commit; then
        print_success "pre-commit installed successfully via global pip."
    else
        print_error "Failed to install pre-commit via global pip. Please ensure pip is installed and in your PATH."
        exit 1
    fi
fi

# Final verification after installation attempt
if ! command_exists pre-commit; then
    print_error "pre-commit command not found after installation. Something went wrong."
    exit 1
fi

print_success "pre-commit setup completed successfully."

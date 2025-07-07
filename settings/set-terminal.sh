#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting default terminal emulator..."

# Function to set the default terminal idempotently
set_default_terminal_idempotent() {
    # Array of installed terminals to consider
    local TERMINALS=("/usr/bin/gnome-terminal" "/usr/bin/xterm" "/usr/bin/konsole" "/usr/bin/alacritty" "/usr/bin/warp-terminal")
    local OPTIONS=()

    print_info "Collecting available terminal emulators..."
    for TERMINAL in "${TERMINALS[@]}"; do
        if [ -f "$TERMINAL" ]; then
            OPTIONS+=("$TERMINAL")
        fi
    done

    if [ ${#OPTIONS[@]} -eq 0 ]; then
        print_error "No available terminals found. Cannot set default terminal."
        return 1
    fi
    print_success "Available terminal emulators collected."

    local current_default_terminal
    current_default_terminal=$(update-alternatives --query x-terminal-emulator | grep "Value:" | awk '{print $2}' || true)

    print_info "Current default terminal: ${current_default_terminal:-"Not set"}"

    local CHOICE
    if [ -n "$current_default_terminal" ] && [[ " ${OPTIONS[*]} " =~ " ${current_default_terminal} " ]]; then
        print_info "Current default terminal '$current_default_terminal' is one of the available options."
        if gum confirm "Do you want to change the default terminal from '$current_default_terminal'?"; then
            print_info "Please select the desired default terminal..."
            CHOICE=$(gum choose "${OPTIONS[@]}")
        else
            print_success "Skipping default terminal change."
            return 0
        fi
    else
        print_info "Please select the desired default terminal..."
        CHOICE=$(gum choose "${OPTIONS[@]}")
    fi

    if [ -z "$CHOICE" ]; then
        print_info "No terminal selected. Skipping default terminal change."
        return 0
    fi

    print_info "Selected terminal: $CHOICE"

    if [ "$CHOICE" = "$current_default_terminal" ]; then
        print_success "Selected terminal '$CHOICE' is already the default. Skipping update."
        return 0
    fi

    print_info "Adding the selected terminal to alternatives..."
    # The priority (50) is arbitrary but common. If it conflicts, update-alternatives will handle it.
    if sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$CHOICE" 50; then
        print_success "Selected terminal added to alternatives."
    else
        print_error "Failed to add the selected terminal to alternatives."
        return 1
    fi

    print_info "Configuring the default terminal..."
    # This command interactively prompts the user, which is generally avoided in automated scripts.
    # However, update-alternatives --config is the standard way to set the default.
    # We will run it, but note that it requires user interaction.
    print_info "Running 'sudo update-alternatives --config x-terminal-emulator'. This command requires user interaction."
    if sudo update-alternatives --config x-terminal-emulator; then
        print_success "Default terminal emulator configured successfully."
    else
        print_error "Failed to configure default terminal emulator. User interaction might be required."
        return 1
    fi

    print_success "Default terminal emulator setup completed."
    return 0
}

set_default_terminal_idempotent

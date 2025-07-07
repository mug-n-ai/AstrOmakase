#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting GNOME Shell extensions..."

# Function to set GNOME extension state (enable/disable) idempotently
set_gnome_extension_state() {
    local action="$1" # "enable" or "disable"
    local extension_id="$2"
    local current_state

    current_state=$(gnome-extensions list --enabled | grep -q "^$extension_id$" && echo "enabled" || echo "disabled")

    if [ "$action" = "enable" ]; then
        if [ "$current_state" = "enabled" ]; then
            print_success "Extension '$extension_id' is already enabled. Skipping."
        else
            print_info "Enabling extension '$extension_id'..."
            if gnome-extensions enable "$extension_id"; then
                print_success "Extension '$extension_id' enabled successfully."
            else
                print_error "Failed to enable extension '$extension_id'."
                return 1
            fi
        fi
    elif [ "$action" = "disable" ]; then
        if [ "$current_state" = "disabled" ]; then
            print_success "Extension '$extension_id' is already disabled. Skipping."
        else
            print_info "Disabling extension '$extension_id'..."
            if gnome-extensions disable "$extension_id"; then
                print_success "Extension '$extension_id' disabled successfully."
            else
                print_error "Failed to disable extension '$extension_id'."
                return 1
            fi
        fi
    else
        print_error "Invalid action '$action' for set_gnome_extension_state. Must be 'enable' or 'disable'."
        return 1
    fi
    return 0
}

# Turn off default Ubuntu extensions idempotently
set_gnome_extension_state "disable" "tiling-assistant@ubuntu.com" || true
set_gnome_extension_state "disable" "ubuntu-dock@ubuntu.com" || true
set_gnome_extension_state "disable" "ding@rastersoft.com" || true

# Enable Ubuntu AppIndicators idempotently
set_gnome_extension_state "enable" "ubuntu-appindicators@ubuntu.com" || true

# Configure TopHat
print_info "Configuring TopHat extension..."
set_gsetting_idempotent org.gnome.shell.extensions.tophat show-icons "true" "TopHat Show Icons" || true
set_gsetting_idempotent org.gnome.shell.extensions.tophat show-cpu "true" "TopHat Show CPU" || true
set_gsetting_idempotent org.gnome.shell.extensions.tophat show-disk "false" "TopHat Show Disk" || true
set_gsetting_idempotent org.gnome.shell.extensions.tophat show-mem "true" "TopHat Show Memory" || true
set_gsetting_idempotent org.gnome.shell.extensions.tophat cpu-display "'numeric'" "TopHat CPU Display" || true
set_gsetting_idempotent org.gnome.shell.extensions.tophat mem-display "'numeric'" "TopHat Memory Display" || true
set_gsetting_idempotent org.gnome.shell.extensions.tophat network-usage-unit "'bits'" "TopHat Network Usage Unit" || true
set_gsetting_idempotent org.gnome.shell.extensions.tophat show-animations "false" "TopHat Show Animations" || true

# Set TopHat color based on the current theme
color="#208fe9"
set_gsetting_idempotent org.gnome.shell.extensions.tophat meter-fg-color "'$color'" "TopHat Meter Foreground Color" || true
print_success "TopHat configuration completed."

# Configure Alphabetical App Grid
print_info "Configuring Alphabetical App Grid extension..."
set_gsetting_idempotent org.gnome.shell.extensions.alphabetical-app-grid folder-order-position "'end'" "Alphabetical App Grid Folder Order Position" || true
print_success "Alphabetical App Grid configuration completed."

# Configure Tactile
print_info "Configuring Tactile extension..."
set_gsetting_idempotent org.gnome.shell.extensions.tactile col-0 "1" "Tactile Column 0" || true
set_gsetting_idempotent org.gnome.shell.extensions.tactile col-1 "2" "Tactile Column 1" || true
set_gsetting_idempotent org.gnome.shell.extensions.tactile col-2 "1" "Tactile Column 2" || true
set_gsetting_idempotent org.gnome.shell.extensions.tactile col-3 "0" "Tactile Column 3" || true
set_gsetting_idempotent org.gnome.shell.extensions.tactile row-0 "1" "Tactile Row 0" || true
set_gsetting_idempotent org.gnome.shell.extensions.tactile row-1 "1" "Tactile Row 1" || true
set_gsetting_idempotent org.gnome.shell.extensions.tactile gap-size "32" "Tactile Gap Size" || true
print_success "Tactile configuration completed."

# Configure Blur My Shell
print_info "Configuring Blur My Shell extension..."
set_gsetting_idempotent org.gnome.shell.extensions.blur-my-shell.appfolder blur "false" "Blur My Shell Appfolder Blur" || true
set_gsetting_idempotent org.gnome.shell.extensions.blur-my-shell.lockscreen blur "false" "Blur My Shell Lockscreen Blur" || true
set_gsetting_idempotent org.gnome.shell.extensions.blur-my-shell.screenshot blur "false" "Blur My Shell Screenshot Blur" || true
set_gsetting_idempotent org.gnome.shell.extensions.blur-my-shell.window-list blur "false" "Blur My Shell Window List Blur" || true
set_gsetting_idempotent org.gnome.shell.extensions.blur-my-shell.panel blur "false" "Blur My Shell Panel Blur" || true
set_gsetting_idempotent org.gnome.shell.extensions.blur-my-shell.overview blur "true" "Blur My Shell Overview Blur" || true
set_gsetting_idempotent org.gnome.shell.extensions.blur-my-shell.overview pipeline "'pipeline_default'" "Blur My Shell Overview Pipeline" || true
set_gsetting_idempotent org.gnome.shell.extensions.blur-my-shell.dash-to-dock blur "true" "Blur My Shell Dash-to-Dock Blur" || true
set_gsetting_idempotent org.gnome.shell.extensions.blur-my-shell.dash-to-dock brightness "0.6" "Blur My Shell Dash-to-Dock Brightness" || true
set_gsetting_idempotent org.gnome.shell.extensions.blur-my-shell.dash-to-dock sigma "30" "Blur My Shell Dash-to-Dock Sigma" || true
set_gsetting_idempotent org.gnome.shell.extensions.blur-my-shell.dash-to-dock static-blur "true" "Blur My Shell Dash-to-Dock Static Blur" || true
set_gsetting_idempotent org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock "0" "Blur My Shell Dash-to-Dock Style" || true
print_success "Blur My Shell configuration completed."

# Configure Space Bar
print_info "Configuring Space Bar extension..."
set_gsetting_idempotent org.gnome.shell.extensions.space-bar.behavior smart-workspace-names "false" "Space Bar Smart Workspace Names" || true
set_gsetting_idempotent org.gnome.shell.extensions.space-bar.shortcuts enable-activate-workspace-shortcuts "false" "Space Bar Enable Activate Workspace Shortcuts" || true
set_gsetting_idempotent org.gnome.shell.extensions.space-bar.shortcuts enable-move-to-workspace-shortcuts "true" "Space Bar Enable Move to Workspace Shortcuts" || true
set_gsetting_idempotent org.gnome.shell.extensions.space-bar.shortcuts open-menu "@as []" "Space Bar Open Menu Shortcut" || true
print_success "Space Bar configuration completed."

print_success "GNOME Shell extensions settings applied successfully."

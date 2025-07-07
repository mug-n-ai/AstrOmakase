#!/bin/bash
set -euo pipefail

# This keybindings are inspired by the Omakub project. Please visit the [Omakub project](https://github.com/basecamp/omakub) 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting hotkeys..."

# Function to set a custom keybinding idempotently
set_custom_keybinding_idempotent() {
    local custom_keybinding_path="$1"
    local name="$2"
    local command="$3"
    local binding="$4"

    local current_custom_bindings
    current_custom_bindings=$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings || true)

    # Check if the custom keybinding path is already in the list
    if ! echo "$current_custom_bindings" | grep -q "'$custom_keybinding_path'"; then
        print_info "Adding custom keybinding path '$custom_keybinding_path' to custom-keybindings list..."
        # Add the new custom keybinding path to the list
        local new_custom_bindings
        new_custom_bindings=$(echo "$current_custom_bindings" | sed "s/\]/, \'$custom_keybinding_path\']/")
        if gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new_custom_bindings"; then
            print_success "Custom keybinding path '$custom_keybinding_path' added to list."
        else
            print_error "Failed to add custom keybinding path '$custom_keybinding_path' to list."
            return 1
        fi
    else
        print_success "Custom keybinding path '$custom_keybinding_path' already in list. Skipping addition."
    fi

    # Set name, command, and binding idempotently
    set_gsetting_idempotent "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$custom_keybinding_path" name "'$name'" "Custom Keybinding Name ($name)" || true
    set_gsetting_idempotent "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$custom_keybinding_path" command "'$command'" "Custom Keybinding Command ($name)" || true
    set_gsetting_idempotent "org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:$custom_keybinding_path" binding "'$binding'" "Custom Keybinding Binding ($name)" || true

    return 0
}

# Alt+F4 is very cumbersome
set_gsetting_idempotent org.gnome.desktop.wm.keybindings close "['<Super>w']" "Close Window Hotkey" || true

# Make it easy to maximize like you can fill left/right
set_gsetting_idempotent org.gnome.desktop.wm.keybindings maximize "['<Super>Up']" "Maximize Window Hotkey" || true

# Full-screen with title/navigation bar
set_gsetting_idempotent org.gnome.desktop.wm.keybindings toggle-fullscreen "['<Shift>F11']" "Toggle Fullscreen Hotkey" || true

# Use 6 fixed workspaces instead of dynamic mode
set_gsetting_idempotent org.gnome.mutter dynamic-workspaces "false" "Dynamic Workspaces" || true
set_gsetting_idempotent org.gnome.desktop.wm.preferences num-workspaces "6" "Number of Workspaces" || true

# Use alt for pinned apps
set_gsetting_idempotent org.gnome.shell.keybindings switch-to-application-1 "['<Alt>1']" "Switch to Application 1" || true
set_gsetting_idempotent org.gnome.shell.keybindings switch-to-application-2 "['<Alt>2']" "Switch to Application 2" || true
set_gsetting_idempotent org.gnome.shell.keybindings switch-to-application-3 "['<Alt>3']" "Switch to Application 3" || true
set_gsetting_idempotent org.gnome.shell.keybindings switch-to-application-4 "['<Alt>4']" "Switch to Application 4" || true
set_gsetting_idempotent org.gnome.shell.keybindings switch-to-application-5 "['<Alt>5']" "Switch to Application 5" || true
set_gsetting_idempotent org.gnome.shell.keybindings switch-to-application-6 "['<Alt>6']" "Switch to Application 6" || true
set_gsetting_idempotent org.gnome.shell.keybindings switch-to-application-7 "['<Alt>7']" "Switch to Application 7" || true
set_gsetting_idempotent org.gnome.shell.keybindings switch-to-application-8 "['<Alt>8']" "Switch to Application 8" || true
set_gsetting_idempotent org.gnome.shell.keybindings switch-to-application-9 "['<Alt>9']" "Switch to Application 9" || true

# Use super for workspaces
set_gsetting_idempotent org.gnome.desktop.wm.keybindings switch-to-workspace-1 "['<Super>1']" "Switch to Workspace 1" || true
set_gsetting_idempotent org.gnome.desktop.wm.keybindings switch-to-workspace-2 "['<Super>2']" "Switch to Workspace 2" || true
set_gsetting_idempotent org.gnome.desktop.wm.keybindings switch-to-workspace-3 "['<Super>3']" "Switch to Workspace 3" || true
set_gsetting_idempotent org.gnome.desktop.wm.keybindings switch-to-workspace-4 "['<Super>4']" "Switch to Workspace 4" || true
set_gsetting_idempotent org.gnome.desktop.wm.keybindings switch-to-workspace-5 "['<Super>5']" "Switch to Workspace 5" || true
set_gsetting_idempotent org.gnome.desktop.wm.keybindings switch-to-workspace-6 "['<Super>6']" "Switch to Workspace 6" || true

# Reserve slots for custom keybindings
# This needs to be handled carefully to ensure idempotency and not overwrite existing custom bindings
# We will ensure the paths exist in the list, but not remove others.
print_info "Ensuring custom keybinding slots are reserved..."
local custom_keybinding_paths=(
    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
    "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/"
)

local current_custom_bindings_array=()
# Read current custom-keybindings into an array
IFS=$'\n' read -d '' -r -a current_custom_bindings_array <<< "$(gsettings get org.gnome.settings-daemon.plugins.media-keys custom-keybindings | sed "s/^@as \['\(.*\)'\]$/\1/" | tr ',' '\n')"

local updated_custom_bindings_array=("${current_custom_bindings_array[@]}")
local needs_update=false

for path in "${custom_keybinding_paths[@]}"; do
    local found=false
    for existing_path in "${updated_custom_bindings_array[@]}"; do
        if [ "$existing_path" = "$path" ]; then
            found=true
            break
        fi
    done
    if [ "$found" = false ]; then
        updated_custom_bindings_array+=("$path")
        needs_update=true
    fi
done

if [ "$needs_update" = true ]; then
    local new_list="$(printf "'%s', " "${updated_custom_bindings_array[@]}" | sed 's/, $/\']/')"
    new_list="[@as [${new_list}]"
    print_info "Updating custom-keybindings list..."
    if gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "$new_list"; then
        print_success "Custom keybinding slots reserved successfully."
    else
        print_error "Failed to reserve custom keybinding slots."
    fi
else
    print_success "Custom keybinding slots already reserved. Skipping."
fi

# Set ulauncher to Super+Space
set_gsetting_idempotent org.gnome.desktop.wm.keybindings switch-input-source "@as []" "Switch Input Source Hotkey" || true
set_custom_keybinding_idempotent "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/" "ulauncher-toggle" "ulauncher-toggle" "<Super>space" || true

# Set flameshot (with the sh fix for starting under Wayland) on alternate print screen key
set_custom_keybinding_idempotent "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/" "Flameshot" "sh -c -- \"flameshot gui\"" "<Control>Print" || true

# Start a new Chrome window (rather than just switch to the already open one)
set_custom_keybinding_idempotent "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom3/" "new chrome" "google-chrome" "<Shift><Alt>1" || true

print_success "Hotkeys setup completed successfully."
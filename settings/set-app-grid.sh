#!/bin/bash
set -euo pipefail

# This settings are inspired by the Omakub project. Please visit the [Omakub project](https://github.com/basecamp/omakub) 
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting up App Grid..."

# Function to update a gsettings list (array) idempotently
update_gsettings_list_idempotent() {
    local schema="$1"
    local key="$2"
    local -n desired_items_array="$3" # Nameref to array of desired items
    local display_name="$4"

    local current_list_str
    current_list_str=$(gsettings get "$schema" "$key" 2>/dev/null || true)

    # Remove leading/trailing brackets and quotes, then split by ', ' into an array
    local current_items_array=()
    if [[ "$current_list_str" =~ ^\[(.*)\]$ ]]; then
        IFS=', ' read -r -a current_items_array <<< "${BASH_REMATCH[1]//'/}"
    fi

    local updated_items_array=("${current_items_array[@]}")
    local needs_update=false

    for desired_item in "${desired_items_array[@]}"; do
        local found=false
        for existing_item in "${updated_items_array[@]}"; do
            if [ "$existing_item" = "$desired_item" ]; then
                found=true
                break
            fi
        done
        if [ "$found" = false ]; then
            updated_items_array+=("$desired_item")
            needs_update=true
        fi
    done

    if [ "$needs_update" = true ]; then
        local new_list_str="$(printf "'%s', " "${updated_items_array[@]}" | sed "s/, $//")"
        new_list_str="[${new_list_str}]"
        print_info "Updating $display_name to: $new_list_str..."
        if gsettings set "$schema" "$key" "$new_list_str"; then
            print_success "$display_name updated successfully."
        else
            print_error "Failed to update $display_name."
            return 1
        fi
    else
        print_success "$display_name is already up-to-date. Skipping."
    fi
    return 0
}

# Create folders and ensure they are in folder-children
print_info "Configuring App Grid folders..."
declare -a desired_folders=('Utilities' 'Sundry' 'YaST' 'Updates' 'Xtra')
update_gsettings_list_idempotent org.gnome.desktop.app-folders folder-children desired_folders "App Grid Folder Children" || true

# Configure 'Updates' folder
print_info "Configuring 'Updates' folder..."
set_gsetting_idempotent org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Updates/ name "'Install & Update'" "Updates Folder Name" || true
declare -a updates_apps=(
    'org.gnome.Software.desktop'
    'software-properties-drivers.desktop'
    'software-properties-gtk.desktop'
    'update-manager.desktop'
    'firmware-updater_firmware-updater.desktop'
    'snap-store_snap-store.desktop'
)
update_gsettings_list_idempotent org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Updates/ apps updates_apps "Updates Folder Apps" || true

# Configure 'Xtra' folder
print_info "Configuring 'Xtra' folder..."
set_gsetting_idempotent org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Xtra/ name "'Xtra'" "Xtra Folder Name" || true
declare -a xtra_apps=(
    'gnome-language-selector.desktop'
    'org.gnome.PowerStats.desktop'
    'yelp.desktop'
)
update_gsettings_list_idempotent org.gnome.desktop.app-folders.folder:/org/gnome/desktop/app-folders/folders/Xtra/ apps xtra_apps "Xtra Folder Apps" || true

print_success "App Grid setup completed successfully."

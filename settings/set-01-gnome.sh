#!/bin/bash
set -euo pipefail

# This settings are inspired by the Omakub project. Please visit the [Omakub project](https://github.com/basecamp/omakub) 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting Gnome Colors..."

# Function to set gsettings key idempotently
set_gsetting_idempotent() {
    local schema="$1"
    local key="$2"
    local value="$3"
    local display_name="$4"

    local current_value
    current_value=$(gsettings get "$schema" "$key" 2>/dev/null || true)

    # Remove quotes from current_value if it's a string
    current_value=$(echo "$current_value" | sed "s/^'\(.*\)'$/\1/")

    if [ "$current_value" = "$value" ]; then
        print_success "Gnome setting '$display_name' is already set to '$value'. Skipping."
    else
        print_info "Setting Gnome setting '$display_name' to '$value'..."
        if gsettings set "$schema" "$key" "$value"; then
            print_success "Gnome setting '$display_name' set successfully."
        else
            print_error "Failed to set Gnome setting '$display_name' to '$value'."
            return 1
        fi
    fi
    return 0
}

set_gsetting_idempotent org.gnome.desktop.interface color-scheme "'prefer-dark'" "Color Scheme" || true
set_gsetting_idempotent org.gnome.desktop.interface cursor-theme "'Yaru'" "Cursor Theme" || true
set_gsetting_idempotent org.gnome.desktop.interface gtk-theme "'Yaru-blue-dark'" "GTK Theme" || true
set_gsetting_idempotent org.gnome.desktop.interface icon-theme "'Yaru-blue'" "Icon Theme" || true
set_gsetting_idempotent org.gnome.desktop.interface accent-color "'blue'" "Accent Color" || true
set_gsetting_idempotent org.gnome.desktop.interface cursor-blink "true" "Cursor Blink" || true
set_gsetting_idempotent org.gnome.desktop.wm.preferences theme "'Yaru-blue-dark'" "Window Manager Theme" || true

print_success "Gnome Colors setup completed."

print_title "Setting GNOME wallpaper..."

WALLPAPER_SOURCE="$HOME/.local/share/astromakase/content/wallpaper.png"
WALLPAPER_DEST_DIR="$HOME/.local/share/backgrounds"
WALLPAPER_DEST_PATH="$WALLPAPER_DEST_DIR/wallpaper.png"
URI="file://$WALLPAPER_DEST_PATH"

if [ ! -f "$WALLPAPER_SOURCE" ]; then
    print_error "Wallpaper source file not found: $WALLPAPER_SOURCE. Skipping wallpaper setup."
else
    print_info "Wallpaper source file found: $WALLPAPER_SOURCE."

    print_info "Ensuring wallpaper destination directory exists..."
    if [ ! -d "$WALLPAPER_DEST_DIR" ]; then
        if mkdir -p "$WALLPAPER_DEST_DIR"; then
            print_success "Wallpaper destination directory created: $WALLPAPER_DEST_DIR."
        else
            print_error "Failed to create wallpaper destination directory: $WALLPAPER_DEST_DIR. Skipping wallpaper setup."
            exit 1
        fi
    else
        print_success "Wallpaper destination directory already exists: $WALLPAPER_DEST_DIR."
    fi

    print_info "Checking if wallpaper needs to be copied..."
    if [ -f "$WALLPAPER_DEST_PATH" ] && cmp -s "$WALLPAPER_SOURCE" "$WALLPAPER_DEST_PATH"; then
        print_success "Wallpaper is already copied and identical. Skipping copy."
    else
        print_info "Copying wallpaper from $WALLPAPER_SOURCE to $WALLPAPER_DEST_PATH..."
        if cp "$WALLPAPER_SOURCE" "$WALLPAPER_DEST_PATH"; then
            print_success "Wallpaper copied successfully."
        else
            print_error "Failed to copy wallpaper. Skipping wallpaper setup."
            exit 1
        fi
    fi

    set_gsetting_idempotent org.gnome.desktop.background picture-uri "'$URI'" "Desktop Background URI" || true
    set_gsetting_idempotent org.gnome.desktop.background picture-uri-dark "'$URI'" "Desktop Background URI (Dark)" || true
    set_gsetting_idempotent org.gnome.desktop.background picture-options "'zoom'" "Desktop Background Picture Options" || true

    print_success "GNOME wallpaper setup completed."
fi

print_title "Setting other GNOME settings..."

# never suspend if plugged in
set_gsetting_idempotent org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout "0" "Sleep Inactive AC Timeout" || true

# Center new windows in the middle of the screen
set_gsetting_idempotent org.gnome.mutter center-new-windows "true" "Center New Windows" || true

# Reveal week numbers in the Gnome calendar
set_gsetting_idempotent org.gnome.desktop.calendar show-weekdate "true" "Show Week Numbers in Calendar" || true

print_success "Other GNOME settings setup completed."

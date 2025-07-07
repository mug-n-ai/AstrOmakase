#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing Inter Font and Cascadia Code Nerd Font..."

# Create the fonts directory if it doesn't exist
FONTS_DIR="$HOME/.local/share/fonts"
print_info "Ensuring fonts directory exists: $FONTS_DIR"
mkdir -p "$FONTS_DIR" || { print_error "Failed to create fonts directory."; exit 1; }
print_success "Fonts directory ensured."

# Function to install Inter Font
install_inter_font() {
    local font_name="Inter"
    local check_file="$FONTS_DIR/Inter-Regular.ttf"

    if [ -f "$check_file" ]; then
        print_success "$font_name is already installed. Skipping download and installation."
        return 0
    fi

    print_info "$font_name not found. Proceeding with installation."
    local tmp_dir
    tmp_dir=$(mktemp -d)
    local inter_zip="$tmp_dir/Inter.zip"

    print_info "Fetching the latest release of Inter Font..."
    local inter_latest_release_url
    inter_latest_release_url=$(curl -s https://api.github.com/repos/rsms/inter/releases/latest | grep "browser_download_url.*zip" | cut -d '"' -f 4)

    if [[ -z "$inter_latest_release_url" ]]; then
        print_error "Failed to fetch the latest Inter release URL. Skipping Inter Font installation."
        rm -rf "$tmp_dir"
        return 1
    fi

    print_info "Downloading Inter Font from: $inter_latest_release_url"
    if ! wget -O "$inter_zip" "$inter_latest_release_url"; then
        print_error "Failed to download Inter Font. Skipping Inter Font installation."
        rm -rf "$tmp_dir"
        return 1
    fi
    print_success "Inter Font downloaded successfully."

    print_info "Unzipping Inter Font..."
    if ! unzip -q "$inter_zip" -d "$tmp_dir/InterFont"; then
        print_error "Failed to unzip Inter Font. Skipping Inter Font installation."
        rm -rf "$tmp_dir"
        return 1
    fi

    print_info "Copying Inter TTF files to $FONTS_DIR..."
    if ls "$tmp_dir/InterFont"/*.ttf &>/dev/null; then
        if cp "$tmp_dir/InterFont"/*.ttf "$FONTS_DIR"; then
            print_success "Inter TTF files copied successfully."
        else
            print_error "Failed to copy Inter TTF files. Skipping Inter Font installation."
            rm -rf "$tmp_dir"
            return 1
        fi
    else
        print_error "No .ttf files found in the Inter release archive. Skipping Inter Font installation."
        rm -rf "$tmp_dir"
        return 1
    fi

    print_info "Cleaning up temporary files for Inter Font..."
    rm -rf "$tmp_dir"
    print_success "Temporary files for Inter Font removed."
    return 0
}

# Function to install Cascadia Code Nerd Font
install_cascadia_code_nerd_font() {
    local font_name="Cascadia Code Nerd Font"
    local check_file="$FONTS_DIR/CaskaydiaCoveNerdFont-Regular.ttf"

    if [ -f "$check_file" ]; then
        print_success "$font_name is already installed. Skipping download and installation."
        return 0
    fi

    print_info "$font_name not found. Proceeding with installation."
    local tmp_dir
    tmp_dir=$(mktemp -d)
    local cascadia_zip="$tmp_dir/CascadiaCode.zip"
    local cascadia_latest_release_url="https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaCode.zip"

    print_info "Downloading Cascadia Code Nerd Font from: $cascadia_latest_release_url"
    if ! wget -O "$cascadia_zip" "$cascadia_latest_release_url"; then
        print_error "Failed to download Cascadia Code Nerd Font. Skipping Cascadia Code Nerd Font installation."
        rm -rf "$tmp_dir"
        return 1
    fi
    print_success "Cascadia Code Nerd Font downloaded successfully."

    print_info "Unzipping Cascadia Code Nerd Font..."
    if ! unzip -q "$cascadia_zip" -d "$tmp_dir/CascadiaFont"; then
        print_error "Failed to unzip Cascadia Code Nerd Font. Skipping Cascadia Code Nerd Font installation."
        rm -rf "$tmp_dir"
        return 1
    fi

    print_info "Copying Cascadia TTF files to $FONTS_DIR..."
    if ls "$tmp_dir/CascadiaFont"/*.ttf &>/dev/null; then
        if cp "$tmp_dir/CascadiaFont"/*.ttf "$FONTS_DIR"; then
            print_success "Cascadia TTF files copied successfully."
        else
            print_error "Failed to copy Cascadia TTF files. Skipping Cascadia Code Nerd Font installation."
            rm -rf "$tmp_dir"
            return 1
        fi
    else
        print_error "No .ttf files found in the Cascadia release archive. Skipping Cascadia Code Nerd Font installation."
        rm -rf "$tmp_dir"
        return 1
    fi

    print_info "Cleaning up temporary files for Cascadia Code Nerd Font..."
    rm -rf "$tmp_dir"
    print_success "Temporary files for Cascadia Code Nerd Font removed."
    return 0
}

install_inter_font || true # Continue even if font installation fails
install_cascadia_code_nerd_font || true # Continue even if font installation fails

print_info "Refreshing font cache..."
if fc-cache -fv; then
    print_success "Font cache refreshed successfully."
else
    print_error "Failed to refresh font cache."
fi

# Apply Inter Font as default font for the system
set_gsetting_idempotent org.gnome.desktop.interface font-name "'Inter 10'" "System Font (Inter)" || true
set_gsetting_idempotent org.gnome.desktop.wm.preferences titlebar-font "'Inter Bold 10'" "Titlebar Font (Inter Bold)" || true

# Apply Cascadia Code Nerd Font as monospace font
set_gsetting_idempotent org.gnome.desktop.interface monospace-font-name "'CaskaydiaCove Nerd Font 10'" "Monospace Font (Cascadia Code Nerd Font)" || true

print_success "Inter and Cascadia Code Nerd Fonts installed and applied successfully!"
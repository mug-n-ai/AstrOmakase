#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Superpaper..."

APP_DIR="$HOME/Applications"
SUPERPAPER_APPIMAGE_NAME="Superpaper-latest-x86_64.AppImage"
SUPERPAPER_APPIMAGE="$APP_DIR/$SUPERPAPER_APPIMAGE_NAME"
SUPERPAPER_ICON="$APP_DIR/superpaper.png"
DESKTOP_ENTRY_FILE="$HOME/.local/share/applications/superpaper.desktop"

# Function to get the current installed Superpaper version (if any)
get_current_superpaper_version() {
    if [ -f "$SUPERPAPER_APPIMAGE" ]; then
        # Attempt to extract version from filename (e.g., Superpaper-1.2.3-x86_64.AppImage)
        local filename=$(basename "$SUPERPAPER_APPIMAGE")
        if [[ "$filename" =~ Superpaper-([0-9]+\.[0-9]+\.[0-9]+)-x86_64\.AppImage ]]; then
            echo "${BASH_REMATCH[1]}"
            return 0
        fi
    fi
    echo ""
    return 1
}

# Function to install or update Superpaper
install_superpaper() {
    print_info "Ensuring $APP_DIR exists..."
    mkdir -p "$APP_DIR" || { print_error "Failed to create $APP_DIR"; return 1; }

    print_info "Fetching the latest Superpaper release information..."
    local latest_release_info
    latest_release_info=$(curl -s https://api.github.com/repos/hhannine/superpaper/releases/latest)
    local latest_version
    latest_version=$(echo "$latest_release_info" | grep "tag_name" | cut -d '"' -f 4)
    local download_url
    download_url=$(echo "$latest_release_info" | grep "browser_download_url.*Superpaper.*x86_64.AppImage" | cut -d '"' -f 4)

    if [ -z "$latest_version" ] || [ -z "$download_url" ]; then
        print_error "Unable to fetch the latest Superpaper release information. Check internet connection or API URL."
        return 1
    fi
    print_success "Latest Superpaper version found: $latest_version."

    local current_version
    current_version=$(get_current_superpaper_version)

    if [ -f "$SUPERPAPER_APPIMAGE" ] && [ "$current_version" = "${latest_version#v}" ]; then
        print_success "Superpaper version $latest_version is already installed. Skipping download and installation."
    else
        if [ -f "$SUPERPAPER_APPIMAGE" ]; then
            print_info "Superpaper is installed but an older version ($current_version). Updating to $latest_version."
            if rm "$SUPERPAPER_APPIMAGE"; then
                print_success "Removed old Superpaper AppImage."
            else
                print_error "Failed to remove old Superpaper AppImage. Aborting update."
                return 1
            fi
        else
            print_info "Superpaper not found. Downloading version $latest_version."
        fi

        print_info "Downloading Superpaper AppImage from $download_url..."
        if ! wget -O "$SUPERPAPER_APPIMAGE" "$download_url"; then
            print_error "Failed to download Superpaper AppImage."
            return 1
        fi
        print_success "Superpaper AppImage downloaded successfully."

        print_info "Making Superpaper AppImage executable..."
        if chmod +x "$SUPERPAPER_APPIMAGE"; then
            print_success "Superpaper AppImage is now executable."
        else
            print_error "Failed to make Superpaper AppImage executable."
            return 1
        fi
    fi

    # Create/Update desktop entry
    print_info "Creating/Updating desktop entry for Superpaper..."
    local desktop_entry_content="[Desktop Entry]\nName=Superpaper\nExec=$SUPERPAPER_APPIMAGE\nIcon=$SUPERPAPER_ICON\nType=Application\nCategories=Utility;"

    if [ -f "$DESKTOP_ENTRY_FILE" ] && grep -qF "$desktop_entry_content" "$DESKTOP_ENTRY_FILE"; then
        print_success "Desktop entry for Superpaper already exists and is up-to-date. Skipping."
    else
        print_info "Writing desktop entry to $DESKTOP_ENTRY_FILE..."
        mkdir -p "$(dirname "$DESKTOP_ENTRY_FILE")" || { print_error "Failed to create desktop entry directory."; return 1; }
        if echo -e "$desktop_entry_content" | tee "$DESKTOP_ENTRY_FILE" > /dev/null; then
            print_success "Desktop entry for Superpaper created/updated successfully."
        else
            print_error "Failed to create/update desktop entry for Superpaper."
            return 1
        fi
    fi

    # Download icon if not present or different
    print_info "Checking Superpaper icon..."
    local icon_url="https://raw.githubusercontent.com/hhannine/superpaper/master/superpaper/resources/superpaper.png"
    if [ -f "$SUPERPAPER_ICON" ]; then
        # Simple check: if file exists, assume it's correct. More robust would be checksum.
        print_success "Superpaper icon already exists. Skipping download."
    else
        print_info "Downloading Superpaper icon from $icon_url..."
        if wget -O "$SUPERPAPER_ICON" "$icon_url"; then
            print_success "Superpaper icon downloaded successfully."
        else
            print_error "Failed to download Superpaper icon."
            # Not critical, so don't exit
        fi
    fi

    print_info "Updating desktop database..."
    if update-desktop-database "$(dirname "$DESKTOP_ENTRY_FILE")"; then
        print_success "Desktop database updated."
    else
        print_error "Failed to update desktop database."
    fi

    print_success "Superpaper installation/update completed successfully."
    return 0
}

install_superpaper

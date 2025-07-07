#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting default applications..."

# Function to set xdg-mime default idempotently
set_xdg_default_idempotent() {
    local desktop_file="$1"
    local mime_type="$2"
    local display_name="$3"

    local current_default
    current_default=$(xdg-mime query default "$mime_type" || true)

    if [ "$current_default" = "$desktop_file" ]; then
        print_success "Default application for '$mime_type' ('$display_name') is already '$desktop_file'. Skipping."
    else
        print_info "Setting default application for '$mime_type' ('$display_name') to '$desktop_file'..."
        if xdg-mime default "$desktop_file" "$mime_type"; then
            print_success "Default application for '$mime_type' set to '$desktop_file'."
        else
            print_error "Failed to set default application for '$mime_type' to '$desktop_file'."
            return 1
        fi
    fi
    return 0
}

print_info "Setting default applications for office file types..."
set_xdg_default_idempotent "onlyoffice-desktopeditors_onlyoffice-desktopeditors.desktop" "application/vnd.openxmlformats-officedocument.wordprocessingml.document" "Word Document" || true
set_xdg_default_idempotent "onlyoffice-desktopeditors_onlyoffice-desktopeditors.desktop" "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" "Spreadsheet" || true
set_xdg_default_idempotent "onlyoffice-desktopeditors_onlyoffice-desktopeditors.desktop" "application/vnd.openxmlformats-officedocument.presentationml.presentation" "Presentation" || true
set_xdg_default_idempotent "onlyoffice-desktopeditors_onlyoffice-desktopeditors.desktop" "text/csv" "CSV File" || true

print_info "Setting default web browser..."
local current_browser
current_browser=$(xdg-settings get default-web-browser || true)
if [ "$current_browser" = "google-chrome.desktop" ]; then
    print_success "Default web browser is already google-chrome.desktop. Skipping."
else
    print_info "Setting default web browser to google-chrome.desktop..."
    if xdg-settings set default-web-browser google-chrome.desktop; then
        print_success "Default web browser set to google-chrome.desktop."
    else
        print_error "Failed to set default web browser to google-chrome.desktop."
        return 1
    fi
fi

print_info "Setting default applications for text file types..."
set_xdg_default_idempotent "zed.desktop" "text/plain" "Plain Text" || true
set_xdg_default_idempotent "zed.desktop" "text/x-python" "Python Script" || true
set_xdg_default_idempotent "zed.desktop" "application/octet-stream" "Binary File" || true
set_xdg_default_idempotent "zed.desktop" "text/x-shellscript" "Shell Script" || true
set_xdg_default_idempotent "zed.desktop" "text/x-log" "Log File" || true
set_xdg_default_idempotent "zed.desktop" "text/xml" "XML File" || true
set_xdg_default_idempotent "zed.desktop" "application/xml" "XML Document" || true
set_xdg_default_idempotent "zed.desktop" "text/x-yaml" "YAML File" || true
set_xdg_default_idempotent "zed.desktop" "application/x-yaml" "YAML Document" || true
set_xdg_default_idempotent "zed.desktop" "text/x-csrc" "C Source" || true
set_xdg_default_idempotent "zed.desktop" "text/x-chdr" "C Header" || true
set_xdg_default_idempotent "zed.desktop" "text/x-c++" "C++ Source" || true
set_xdg_default_idempotent "zed.desktop" "text/x-c++hdr" "C++ Header" || true
set_xdg_default_idempotent "zed.desktop" "text/x-c++src" "C++ Source" || true
set_xdg_default_idempotent "zed.desktop" "text/markdown" "Markdown File" || true
set_xdg_default_idempotent "zed.desktop" "application/json" "JSON File" || true
set_xdg_default_idempotent "zed.desktop" "text/x-ini" "INI File" || true
set_xdg_default_idempotent "zed.desktop" "text/x-config" "Config File" || true

print_success "Default applications setup completed successfully."

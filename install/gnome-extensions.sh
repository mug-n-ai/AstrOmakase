#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

# Function to check if an extension is installed
extension_installed() {
    local extension_id="$1"
    gnome-extensions list | grep -q "$extension_id"
}

#install gnome extensions
echo "Installing GNOME extensions..."
# other extension are inclused in Omakub
sudo apt install -y gnome-shell-extension-manager pipx
pipx install gnome-extensions-cli --system-site-packages


# Check if gnome-shell-extension-manager is installed
if command_exists gnome-shell-extension-manager; then
    print_success "Gnome shell extension manager is already installed."
else
    apt_install gnome-shell-extension-manager
fi

# Check if pipx is installed
if command_exists pipx; then
    print_success "pipx is already installed."
else
    apt_install pipx
    pipx install gnome-extensions-cli --system-site-packages
fi

# Install new extensions only if they are not already installed
if extension_installed "undecorate@sun.wxg@gmail.com"; then
    print_success "Extension 'undecorate@sun.wxg@gmail.com' is already installed."
else
    gext install undecorate@sun.wxg@gmail.com
fi

# remove Vitals extension if it is installed (by Omakub)
if extension_installed "Vitals@CoreCoding.com"; then
    gext uninstall Vitals@CoreCoding.com
fi

if extension_installed "tophat@fflewddur.github.io"; then
    print_success "Extension 'tophat@fflewddur.github.io' is already installed."
else
    gext install tophat@fflewddur.github.io
fi

if extension_installed "AlphabeticalAppGrid@stuarthayhurst"; then
    print_success "Extension 'AlphabeticalAppGrid@stuarthayhurst' is already installed."
else
    gext install AlphabeticalAppGrid@stuarthayhurst
fi

if extension_installed "IP-Finder@linxgem33.com"; then
    print_success "Extension 'IP-Finder@linxgem33.com' is already installed."
else
    gext install IP-Finder@linxgem33.com
fi

# Compile gsettings schemas only if the extensions were installed
if [ -f ~/.local/share/gnome-shell/extensions/tophat@fflewddur.github.io/schemas/org.gnome.shell.extensions.tophat.gschema.xml ]; then
    sudo cp ~/.local/share/gnome-shell/extensions/tophat@fflewddur.github.io/schemas/org.gnome.shell.extensions.tophat.gschema.xml /usr/share/glib-2.0/schemas/
fi

if [ -f ~/.local/share/gnome-shell/extensions/AlphabeticalAppGrid@stuarthayhurst/schemas/org.gnome.shell.extensions.AlphabeticalAppGrid.gschema.xml ]; then
    sudo cp ~/.local/share/gnome-shell/extensions/AlphabeticalAppGrid@stuarthayhurst/schemas/org.gnome.shell.extensions.AlphabeticalAppGrid.gschema.xml /usr/share/glib-2.0/schemas/
fi

sudo glib-compile-schemas /usr/share/glib-2.0/schemas/

#!/bin/bash

# Check if the running system is Ubuntu 24.04
if ! lsb_release -d | grep -q "Ubuntu 24.04"; then
    print_error "This script is designed for Ubuntu 24.04. Exiting."
    exit 1
fi


if $RUNNING_GNOME; then
	# Ensure computer doesn't go to sleep or lock while installing
	gsettings set org.gnome.desktop.screensaver lock-enabled false
	gsettings set org.gnome.desktop.session idle-delay 0
fi


OMAKUB_DIR="$HOME/.local/share/omakub"

if [ ! -d "$OMAKUB_DIR" ]; then
    echo "The default omakub directory was not found."
    echo "For a better experience we suggest to start from Omakub installation."
    echo "Please check if the package is installed."
    read -p "Do you want to proceed anyway? (y/n): " response

    if [[ "$response" != "y" && "$response" != "Y" ]]; then
        echo "Operation cancelled by the user."
        exit 1
    fi
else
    if ! grep -q "hash -r" ~/.bashrc; then
        # fixing disabled hasing problem
        echo "hash -r" >> ~/.bashrc
    fi

fi
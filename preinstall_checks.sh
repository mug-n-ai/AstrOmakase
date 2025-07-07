#!/bin/bash

source "$(dirname "${BASH_SOURCE[0]}")/common_functions.sh"

# Check if the running system is Ubuntu 24.04
if ! lsb_release -d | grep -q "Ubuntu 24.04"; then
    print_error "This script is designed for Ubuntu 24.04. Exiting."
    exit 1
fi

# Check if GNOME is running
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
    RUNNING_GNOME=true
else
    RUNNING_GNOME=false
fi

if $RUNNING_GNOME; then
	# Ensure computer doesn't go to sleep or lock while installing
	gsettings set org.gnome.desktop.screensaver lock-enabled false
	gsettings set org.gnome.desktop.session idle-delay 0
fi


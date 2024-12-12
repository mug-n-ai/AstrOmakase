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


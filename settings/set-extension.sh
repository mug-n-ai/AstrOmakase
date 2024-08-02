#!/bin/bash

# enable Ubuntu AppIndicators
gnome-extensions enable ubuntu-appindicators@ubuntu.com

# Configure Vitals
gsettings set org.gnome.shell.extensions.vitals hide-icons false
gsettings set org.gnome.shell.extensions.vitals hot-sensors "['_processor_usage_', '_memory_usage_', '__temperature_avg__', '__network-rx_max__']"
gsettings set org.gnome.shell.extensions.vitals icon-style 0
gsettings set org.gnome.shell.extensions.vitals network-speed-format 1

# configure Alphabetical App Grid
gsettings set org.gnome.shell.extensions.alphabetical-app-grid folder-order-position 'end'

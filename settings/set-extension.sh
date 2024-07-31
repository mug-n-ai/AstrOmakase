#!/bin/bash

# Configure Vitals
gsettings set org.gnome.shell.extensions.vitals hide-icons false
gsettings set org.gnome.shell.extensions.vitals hot-sensors "['_processor_usage_', '_memory_usage_', '__temperature_avg__', '__network-rx_max__']"
gsettings set org.gnome.shell.extensions.vitals icon-style 0
gsettings set org.gnome.shell.extensions.vitals network-speed-format 1

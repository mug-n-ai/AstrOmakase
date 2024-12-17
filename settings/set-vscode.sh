#!/bin/bash

# This settings are inspired by the Omakub project. Please visit the [Omakub project](https://github.com/basecamp/omakub) 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting VSCode theme..."

VSC_THEME="Tokyo Night"
VSC_EXTENSION="enkia.tokyo-night"

code --install-extension $VSC_EXTENSION >/dev/null
sed -i "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$VSC_THEME\"/g" ~/.config/Code/User/settings.json

print_success "VSCode theme setup complete"
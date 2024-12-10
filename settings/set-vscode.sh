#!/bin/bash

# This settings are inspired by the Omakub project. Please visit the [Omakub project](https://github.com/basecamp/omakub) 

echo "Setting VSCode theme..."

VSC_THEME="Tokyo Night"
VSC_EXTENSION="enkia.tokyo-night"

code --install-extension $VSC_EXTENSION >/dev/null
sed -i "s/\"workbench.colorTheme\": \".*\"/\"workbench.colorTheme\": \"$VSC_THEME\"/g" ~/.config/Code/User/settings.json

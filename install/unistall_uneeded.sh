#!/bin/bash

OMAKUB_DIR="$HOME/.local/share/omakub"


# Uninstall un-needed Omakub software
echo "Removing un-needed tools"
TO_REMOVE_APP=("1password" "audacity" "ollama" "pinta" "signal" "spotify" "steam" "web" "rubymine")
for app in "${TO_REMOVE_APP[@]}"; do
    echo "Uninstalling ${app}..."
    if ! source "$OMAKUB_DIR/uninstall/app-${app}.sh"; then
        echo "Failed to uninstall ${app}. It might not be installed."
    fi
done

# remove Vitals extension if it is installed (by Omakub)
if extension_installed "Vitals@CoreCoding.com"; then
    gext uninstall Vitals@CoreCoding.com
fi

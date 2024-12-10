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

# remove mise
echo  "Removing mise: to uninstall, select Yes when prompted"
if command_exists mise; then
    sudo mise implode
fi

echo "cleaning bashrc..."
if ! grep -q 'source ~/.local/share/omakub/defaults/bash/rc' "$HOME/.bashrc"; then
# todo remove the line


rm -rf $OMAKUB_DIR

echo "Migration complete."

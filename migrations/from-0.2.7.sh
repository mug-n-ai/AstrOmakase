#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"


print_title "Migrating from 0.2.7..."

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

echo "Cleaning .bashrc..."
OMAKUB_BASHRC_LINE='source ~/.local/share/omakub/defaults/bash/rc'
SET_H_LINE='set -h'

# Escape special characters for use in sed
ESCAPED_OMAKUB_LINE=$(printf '%s\n' "$OMAKUB_BASHRC_LINE" | sed 's/[.[\*^$\/]/\\&/g')
ESCAPED_SET_H_LINE=$(printf '%s\n' "$SET_H_LINE" | sed 's/[.[\*^$\/]/\\&/g')

# Remove Omakub line if present
if grep -q "$OMAKUB_BASHRC_LINE" "$HOME/.bashrc"; then
    sed -i "/$ESCAPED_OMAKUB_LINE/d" "$HOME/.bashrc"
    echo "Removed Omakub-specific line from .bashrc"
else
    echo "No Omakub-specific line found in .bashrc"
fi

# Remove set -h if present
if grep -q "$SET_H_LINE" "$HOME/.bashrc"; then
    sed -i "/$ESCAPED_SET_H_LINE/d" "$HOME/.bashrc"
    echo "Removed 'set -h' line from .bashrc"
else
    echo "No 'set -h' line found in .bashrc"
fi


rm -rf $OMAKUB_DIR

echo "Migration complete."

print_success "Migration from 0.2.7 complete"
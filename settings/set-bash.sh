#!/bin/bash
set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting up bash..."

# Add the path to the .bashrc file only if it does not already exist
if ! grep -q "source \"$HOME/.local/share/astromakase/settings/config/bash/init\"" "$HOME/.bashrc"; then
    echo ' ' >> "$HOME/.bashrc"
    echo "source \"$HOME/.local/share/astromakase/settings/config/bash/init\"" >> "$HOME/.bashrc"
    echo "init added to .bashrc"
else
    echo "init already exists in .bashrc"
fi

# Enable coloured terminal prompts
if ! grep -q 'force_color_prompt=yes' "$HOME/.bashrc"; then
    cat << 'EOF_BASHRC_COLOR' >> "$HOME/.bashrc"

force_color_prompt=yes
color_prompt=yes

PS1= 

# Backup the existing inputrc file if it exists
[ -f "$HOME/.inputrc" ] && mv "$HOME"/.inputrc "$HOME"/.inputrc.bak

# Replace the inputrc file with the default configuration from AstrOmakase
cp "$HOME"/.local/share/astromakase/settings/config/bash/inputrc "$HOME"/.inputrc
echo "inputrc file updated"

print_success "bash setup complete"\uf0a9 '
PS1="\[\e]0;\w\a\]$PS1"
EOF_BASHRC_COLOR
    echo "colors added to .bashrc"
else
    echo "colors already exist in .bashrc"
fi 

# Backup the existing inputrc file if it exists
[ -f "$HOME/.inputrc" ] && mv "$HOME"/.inputrc "$HOME"/.inputrc.bak

# Replace the inputrc file with the default configuration from AstrOmakase
cp "$HOME"/.local/share/astromakase/settings/config/bash/inputrc "$HOME"/.inputrc
echo "inputrc file updated"

print_success "bash setup complete"
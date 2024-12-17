#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting default terminal emulator..."

# Array of installed terminals
TERMINALS=("/usr/bin/gnome-terminal" "/usr/bin/xterm" "/usr/bin/konsole" "/usr/bin/alacritty" "/usr/bin/warp-terminal")

echo "Collecting available terminal emulators..."

# Create a list of available terminals
OPTIONS=()
for TERMINAL in "${TERMINALS[@]}"; do
    if [ -f "$TERMINAL" ]; then
        OPTIONS+=("$TERMINAL")
    fi
done

if [ ${#OPTIONS[@]} -eq 0 ]; then
    echo "No available terminals found. Exiting."
    exit 1
fi

echo "Available terminal emulators collected. Please select the desiderd default terminal..."

# Use gum for selection
CHOICE=$(gum choose "${OPTIONS[@]}")

if [ -z "$CHOICE" ]; then
    echo "No terminal selected. Exiting."
    exit 1
fi

echo "Selected terminal: $CHOICE"

# Add the selected terminal to the alternatives
echo "Adding the selected terminal to alternatives..."
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator "$CHOICE" 50

echo "Done. To configure the default terminal, run 'sudo update-alternatives --config x-terminal-emulator'."

sudo update-alternatives --config x-terminal-emulator


print_success "Default terminal emulator set successfully."
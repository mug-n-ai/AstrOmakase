#!/bin/bash

# Array of installed terminals
TERMINALS=("/usr/bin/gnome-terminal" "/usr/bin/xterm" "/usr/bin/konsole" "/usr/bin/alacritty")

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


echo "Setting up FastFetch..."
INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

if [ -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  gum confirm "It appears that a fastfetch configuration is already set. Do you want to overwrite it?" && rm "$HOME/.config/fastfetch/config.jsonc"
fi

if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  # Use Omakub fastfetch config
  mkdir -p ~/.config/fastfetch
  cp $INSTALL_DIR/config/fastfetch.jsonc ~/.config/fastfetch/config.jsonc
fi

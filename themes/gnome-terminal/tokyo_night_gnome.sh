#!/bin/bash

echo "Configuring Tokyo Night theme for GNOME Terminal..."

# Ottieni l'UUID del profilo predefinito
PROFILE_ID=$(gsettings get org.gnome.Terminal.ProfilesList default | tr -d "'")

# Colori del tema Tokyo Night
FOREGROUND_COLOR="#a9b1d6"
BACKGROUND_COLOR="#1a1b26"
ACCENT_COLOR="#7aa2f7"

PALETTE="['#32344a', '#f7768e', '#9ece6a', '#e0af68', '#7aa2f7', '#ad8ee6', '#449dab', '#787c99', '#444b6a', '#ff7a93', '#b9f27c', '#ff9e64', '#7da6ff', '#bb9af7', '#0db9d7', '#acb0d0']"

# Configura i colori del profilo
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/foreground-color" "'$FOREGROUND_COLOR'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/background-color" "'$BACKGROUND_COLOR'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/palette" "$PALETTE"

# Configura opzioni aggiuntive
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/bold-color" "'$ACCENT_COLOR'"
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/use-theme-colors" "false"
dconf write "/org/gnome/terminal/legacy/profiles:/:$PROFILE_ID/use-transparent-background" "false"


# Add the path to the .bashrc file only if it does not already exist
if ! grep -q 'source "$HOME/.local/share/astromakase/settings/config/bash/init' "$HOME/.bashrc"; then
    echo ' ' >> "$HOME/.bashrc"
    echo 'source "$HOME/.local/share/astromakase/settings/config/bash/init"' >> "$HOME/.bashrc"
    echo "init added to .bashrc"
else
    echo "init already exists in .bashrc"
fi

# Enable coloured terminal prompts
if ! grep -q 'force_color_prompt=yes' "$HOME/.bashrc"; then
    echo ' ' >> "$HOME/.bashrc"
    echo 'force_color_prompt=yes' >> "$HOME/.bashrc"
    echo 'color_prompt=yes' >> "$HOME/.bashrc"
    echo ' ' >> "$HOME/.bashrc"
    echo "PS1=$'\uf0a9 '" >> "$HOME/.bashrc"
    echo 'PS1="\[\e]0;\w\a\]$PS1"' >> "$HOME/.bashrc"
else
    echo "colors already exist in .bashrc"
fi 

# Backup the existing inputrc file if it exists
[ -f "$HOME/.inputrc" ] && mv $HOME/.inputrc $HOME/.inputrc.bak

# Replace the inputrc file with the default configuration from AstrOmakase
cp $HOME/.local/share/astromakase/settings/config/inputrc $HOME/.inputrc

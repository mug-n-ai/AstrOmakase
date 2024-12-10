# Aggiunta del percorso al file .bashrc solo se non esiste già
if ! grep -q 'source "$HOME/.local/share/astromakase/settings/config/bash/init' "$HOME/.bashrc"; then
    echo ' ' >> "$HOME/.bashrc"
    echo 'source "$HOME/.local/share/astromakase/settings/config/bash/init"' >> "$HOME/.bashrc"
    echo "init added to .bashrc"
else
    echo "init already exists in .bashrc"
fi


# Technicolor dreams
if ! grep -q 'force_color_prompt=yes' "$HOME/.bashrc"; then
    echo ' ' >> "$HOME/.bashrc"
    echo 'force_color_prompt=yes' >> "$HOME/.bashrc"
    echo 'color_prompt=yes' >> "$HOME/.bashrc"
    echo ' ' >> "$HOME/.bashrc"
    echo "PS1=$'\uf0a9 '" >> "$HOME/.bashrc"
    echo 'PS1="\[\e]0;\w\a\]$PS1"' >> "$HOME/.bashrc"
else
    echo "colors already exists in .bashrc"
fi 


[ -f "~/.inputrc" ] && mv ~/.inputrc ~/.inputrc.bak
# Configure the inputrc using Omakub defaults
cp ~/.local/share/astriomakase/settings/configs/inputrc ~/.inputrc
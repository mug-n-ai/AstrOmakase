#!/bin/bash

# Creazione del file AstrOmakase.desktop
cat <<EOF >~/.local/share/applications/AstrOmakase.desktop
[Desktop Entry]
Version=1.0
Name=AstrOmakase
Comment=AstrOmakase launcher
Exec=astromakase
Terminal=true
Type=Application
Icon=/home/$USER/.local/share/astromakase/content/icon.png
Categories=Utility;System;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF


# Aggiungi i permessi di esecuzione al file astromakase
sudo chmod +x $HOME/.local/share/astromakase/bin/astromakase

# Aggiunta del percorso al file .bashrc solo se non esiste già
if ! grep -q 'export PATH="$HOME/.local/share/astromakase/bin:$PATH"' "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.local/share/astromakase/bin:$PATH"' >> "$HOME/.bashrc"
    echo "PATH added to .bashrc"
else
    echo "PATH already exists in .bashrc"
fi

# Rendi effettivo il cambiamento nella sessione corrente
export PATH="$HOME/.local/share/astromakase/bin:$PATH"

echo "Setup complete!"

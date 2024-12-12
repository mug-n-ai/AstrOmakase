#!/bin/bash

# Create the AstrOmakase.desktop file
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

# Add execution permissions to the astromakase file
sudo chmod +x $HOME/.local/share/astromakase/bin/astromakase

# Add the path to .bashrc only if it does not already exist
if ! grep -q 'export PATH="$HOME/.local/share/astromakase/bin:$PATH"' "$HOME/.bashrc"; then
    echo 'export PATH="$HOME/.local/share/astromakase/bin:$PATH"' >> "$HOME/.bashrc"
    echo "PATH added to .bashrc"
else
    echo "PATH already exists in .bashrc"
fi

# Apply the PATH change to the current session
export PATH="$HOME/.local/share/astromakase/bin:$PATH"

echo "Setup complete!"

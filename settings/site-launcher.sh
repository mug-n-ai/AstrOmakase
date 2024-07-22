#!/bin/bash


cat <<EOF >~/.local/share/applications/AstrOmakase.desktop
[Desktop Entry]
Version=1.0
Name=AstrOmakase
Comment=Name=AstrOmakase Project Repository
Exec=google-chrome --app="https://github.com/LorenzoMugnai/AstrOmakase" --name=AstrOmakase
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/astromakase/content/icon.png
Categories=GTK;
MimeType=text/html;text/xml;application/xhtml_xml;
StartupNotify=true
EOF

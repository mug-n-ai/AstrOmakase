cat <<EOF >~/.local/share/applications/Activity.desktop
[Desktop Entry]
Version=1.0
Name=Activity
Comment=System activity from btop
Exec=gnome-terminal --geometry=120x30 -- btop
Terminal=false
Type=Application
Icon=/home/$USER/.local/share/astromakase/applications/icons/Activity.png
Categories=GTK;
StartupNotify=false
EOF


update-desktop-database ~/.local/share/applications

# This settings are inspired by the Omakub project. Please visit the [Omakub project](https://github.com/basecamp/omakub) 

# Start ulauncher to have it populate config before we overwrite
mkdir -p $HOME/.config/autostart/
cp $HOME/.local/share/astromakase/settings/config/ulauncher/ulauncher.desktop $HOME/.config/autostart/ulauncher.desktop
gtk-launch ulauncher.desktop >/dev/null 2>&1
sleep 2 # ensure enough time for ulauncher to set defaults
cp $HOME/.local/share/astromakase/settings/config/ulauncher/ulauncher.json $HOME/.config/ulauncher/settings.json

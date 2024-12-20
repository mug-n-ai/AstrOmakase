# This settings are inspired by the Omakub project. Please visit the [Omakub project](https://github.com/basecamp/omakub) 

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Setting up Ulauncher..."
# Start ulauncher to have it populate config before we overwrite
mkdir -p $HOME/.config/autostart/
cp $HOME/.local/share/astromakase/settings/config/ulauncher/ulauncher.desktop $HOME/.config/autostart/ulauncher.desktop
gtk-launch ulauncher.desktop >/dev/null 2>&1
sleep 2 # ensure enough time for ulauncher to set defaults
cp $HOME/.local/share/astromakase/settings/config/ulauncher/ulauncher.json $HOME/.config/ulauncher/settings.json

print_success "Ulauncher setup complete"
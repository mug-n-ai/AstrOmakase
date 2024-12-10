mkdir -p ~/.local/share/fonts

cd /tmp
wget https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip
unzip CascadiaMono.zip -d CascadiaFont
cp CascadiaFont/*.ttf ~/.local/share/fonts
rm -rf CascadiaMono.zip CascadiaFont

# Set Cascadia Mono as the default monospace font #todo change to Fira
gsettings set org.gnome.desktop.interface monospace-font-name 'CaskaydiaMono Nerd Font 10'

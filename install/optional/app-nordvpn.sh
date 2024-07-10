cd /tmp
wget -qO - https://downloads.nordcdn.com/apps/linux/install.sh
sudo usermod -aG nordvpn $USER
sh ./install.sh
rm install.sh
cd -
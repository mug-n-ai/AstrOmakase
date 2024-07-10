sudo apt install -y libx11-dev libxext-dev libxss-dev libxkbfile-dev

cd /tmp
wget -O franz.deb 'https://github.com/meetfranz/franz/releases/download/v5.10.0/franz_5.10.0_amd64.deb'
sudo apt install -y ./franz.deb
rm slack.deb
cd -


cd /tmp
wget -O slack.deb 'https://slack.com/downloads/instructions/linux?ddl=1&build=deb'
sudo apt install -y ./slack.deb
rm slack.deb
cd -

cd /tmp
wget -O pdfsam.deb https://github.com/torakiki/pdfsam/releases/download/v5.2.3/pdfsam_5.2.3-1_amd64.deb

sudo apt install -y ./pdfsam.deb
rm pdfsam.deb
cd -
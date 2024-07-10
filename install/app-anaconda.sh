sudo apt-get install -y libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6

cd /tmp
wget -O anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-x86_64.sh
bash anaconda.sh
rm anaconda.sh
cd -

export PATH="$HOME/anaconda3/bin:$PATH"

conda update -n base -c defaults conda -y

conda install -n base numpy pandas matplotlib scipy astropy jupyter -y

echo "Anaconda installed and set."
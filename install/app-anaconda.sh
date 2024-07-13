# Function to print error messages
print_error() {
    echo "[ERROR] $1" >&2
}

# Function to print success messages
print_success() {
    echo "[SUCCESS] $1"
}

echo "Installing required libraries..."
sudo apt-get install -y libgl1-mesa-glx libegl1-mesa libxrandr2 libxrandr2 libxss1 libxcursor1 libxcomposite1 libasound2 libxi6 libxtst6
if [ $? -ne 0 ]; then
    print_error "Failed to install required libraries. Exiting."
    exit 1
fi
print_success "Required libraries installed successfully."

echo "Downloading Anaconda installer..."
wget -O /tmp/anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-x86_64.sh
if [ $? -ne 0 ]; then
    print_error "Failed to download Anaconda installer. Exiting."
    exit 1
fi
print_success "Anaconda installer downloaded successfully."

echo "Installing Anaconda..."
bash /tmp/anaconda.sh -b -p $HOME/anaconda3
if [ $? -ne 0 ]; then
    print_error "Failed to install Anaconda. Exiting."
    exit 1
fi
print_success "Anaconda installed successfully."

echo "Cleaning up..."
rm /tmp/anaconda.sh
if [ $? -ne 0 ]; then
    print_error "Failed to remove temporary files."
else
    print_success "Removed temporary files."
fi

echo "Updating PATH environment variable..."
export PATH="$HOME/anaconda3/bin:$PATH"
if [ $? -ne 0 ]; then
    print_error "Failed to update PATH environment variable. Exiting."
    exit 1
fi
print_success "PATH environment variable updated."

echo "Updating Conda..."
conda update -n base -c defaults conda -y
if [ $? -ne 0 ]; then
    print_error "Failed to update Conda. Exiting."
    exit 1
fi
print_success "Conda updated successfully."

echo "Installing common packages..."
conda install -n base numpy pandas matplotlib scipy astropy jupyter -y
if [ $? -ne 0 ]; then
    print_error "Failed to install common packages. Exiting."
    exit 1
fi
print_success "Common packages installed successfully."

echo "Anaconda installed and set up successfully."

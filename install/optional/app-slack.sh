# Function to print error messages
print_error() {
    echo "[ERROR] $1" >&2
}

# Function to print success messages
print_success() {
    echo "[SUCCESS] $1"
}

echo "Checking for Snap installation..."
if ! command -v snap &> /dev/null; then
    echo "Snap is not installed. Installing Snap..."
    sudo apt update
    sudo apt install -y snapd
    if [ $? -ne 0 ]; then
        print_error "Failed to install Snap. Exiting."
        exit 1
    fi
    print_success "Snap installed successfully."
else
    print_success "Snap is already installed."
fi

echo "Ensuring Snapd is enabled and started..."
sudo systemctl enable --now snapd
if [ $? -ne 0 ]; then
    print_error "Failed to enable/start Snapd. Exiting."
    exit 1
fi
print_success "Snapd is enabled and started."

echo "Installing Slack via Snap..."
sudo snap install slack --classic
if [ $? -ne 0 ]; then
    print_error "Failed to install Slack via Snap. Exiting."
    exit 1
fi
print_success "Slack installed successfully via Snap."

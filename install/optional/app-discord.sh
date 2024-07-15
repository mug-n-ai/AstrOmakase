SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"  


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

echo "Installing Discord via Snap..."
sudo snap install discord
if [ $? -ne 0 ]; then
    print_error "Failed to install Discord via Snap. Exiting."
    exit 1
fi
print_success "Discord installed successfully via Snap."

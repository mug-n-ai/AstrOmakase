SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

echo "Checking if Zoom is already installed..."
if command -v zoom &> /dev/null; then
    print_success "Zoom is already installed. Exiting script."
    exit 0
fi

echo "Downloading Zoom..."
wget -O /tmp/zoom.deb https://zoom.us/client/latest/zoom_amd64.deb
if [ $? -ne 0 ]; then
    print_error "Failed to download Zoom. Exiting."
    exit 1
fi
print_success "Zoom downloaded successfully."

echo "Installing Zoom..."
sudo apt install -y /tmp/zoom.deb
if [ $? -ne 0 ]; then
    print_error "Failed to install Zoom. Exiting."
    exit 1
fi
print_success "Zoom installed successfully."

echo "Removing temporary files..."
rm /tmp/zoom.deb
if [ $? -ne 0 ]; then
    print_error "Failed to remove temporary files."
else
    print_success "Temporary files removed successfully."
fi

echo "Zoom setup completed successfully."

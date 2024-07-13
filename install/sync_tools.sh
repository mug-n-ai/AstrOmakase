# Function to print error messages
print_error() {
    echo "[ERROR] $1" >&2
}

# Function to print success messages
print_success() {
    echo "[SUCCESS] $1"
}

echo "Installing sync tools..."
sudo apt install -y rclone rsync
if [ $? -ne 0 ]; then
    print_error "Failed to install sync tools. Exiting."
    exit 1
fi
print_success "sync tools installed successfully."




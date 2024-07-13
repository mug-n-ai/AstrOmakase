# Function to print error messages
print_error() {
    echo "[ERROR] $1" >&2
}

# Function to print success messages
print_success() {
    echo "[SUCCESS] $1"
}

echo "Installing kdiff..."
sudo apt install -y kdiff
if [ $? -ne 0 ]; then
    print_error "Failed to install kdiff. Exiting."
    exit 1
fi
print_success "kdiff installed successfully."

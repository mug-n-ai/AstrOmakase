# Function to print error messages
print_error() {
    echo "[ERROR] $1" >&2
}

# Function to print success messages
print_success() {
    echo "[SUCCESS] $1"
}

echo "Installing hdf-compass..."
sudo apt install -y hdf-compass
if [ $? -ne 0 ]; then
    print_error "Failed to install hdf-compass. Exiting."
    exit 1
fi
print_success "hdf-compass installed successfully."


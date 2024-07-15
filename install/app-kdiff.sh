# Function to print error messages
print_error() {
    echo "[ERROR] $1" >&2
}

# Function to print success messages
print_success() {
    echo "[SUCCESS] $1"
}

echo "Installing kdiff3..."
sudo apt install -y kdiff3
if [ $? -ne 0 ]; then
    print_error "Failed to install kdiff3. Exiting."
    exit 1
fi
print_success "kdiff3 installed successfully."

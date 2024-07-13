
# Function to print error messages
print_error() {
    echo "[ERROR] $1" >&2
}

# Function to print success messages
print_success() {
    echo "[SUCCESS] $1"
}

echo "Installing texstudio..."
sudo apt install -y texstudio
if [ $? -ne 0 ]; then
    print_error "Failed to install texstudio. Exiting."
    exit 1
fi
print_success "texstudio installed successfully."

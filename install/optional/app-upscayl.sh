# Function to print error messages
print_error() {
    echo "[ERROR] $1" >&2
}

# Function to print success messages
print_success() {
    echo "[SUCCESS] $1"
}

echo "Checking for Flatpak installation..."
if ! command -v flatpak &> /dev/null; then
    echo "Flatpak is not installed. Installing Flatpak..."
    sudo apt install -y flatpak
    if [ $? -ne 0 ]; then
        print_error "Failed to install Flatpak. Exiting."
        exit 1
    fi
    print_success "Flatpak installed successfully."
else
    print_success "Flatpak is already installed."
fi

echo "Installing Upscayl via Flatpak..."
flatpak install -y flathub com.github.linuxguy123.Upscayl
if [ $? -ne 0 ]; then
    print_error "Failed to install Upscayl via Flatpak. Exiting."
    exit 1
fi

print_success "Upscayl installed successfully via Flatpak."

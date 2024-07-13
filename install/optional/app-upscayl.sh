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

echo "Adding Flathub repository to Flatpak..."
flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
if [ $? -ne 0 ]; then
    print_error "Failed to add Flathub repository. Exiting."
    exit 1
fi
print_success "Flathub repository added successfully."

echo "Installing Upscayl via Flatpak..."
flatpak install flathub org.upscayl.Upscayl
if [ $? -ne 0 ]; then
    print_error "Failed to install Upscayl via Flatpak. Exiting."
    exit 1
fi

print_success "Upscayl installed successfully via Flatpak."

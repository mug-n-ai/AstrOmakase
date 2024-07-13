# Function to print error messages
print_error() {
    echo "[ERROR] $1" >&2
}

# Function to print success messages
print_success() {
    echo "[SUCCESS] $1"
}

echo "Downloading PDFsam .deb package..."
wget -O /tmp/pdfsam.deb https://github.com/torakiki/pdfsam/releases/download/v5.2.3/pdfsam_5.2.3-1_amd64.deb
if [ $? -ne 0 ]; then
    print_error "Failed to download PDFsam. Exiting."
    exit 1
fi
print_success "PDFsam .deb package downloaded successfully."

echo "Installing PDFsam..."
sudo apt install -y /tmp/pdfsam.deb
if [ $? -ne 0 ]; then
    print_error "Failed to install PDFsam. Exiting."
    exit 1
fi
print_success "PDFsam installed successfully."

echo "Cleaning up..."
rm /tmp/pdfsam.deb
if [ $? -ne 0 ]; then
    print_error "Failed to remove temporary files."
else
    print_success "Removed temporary files."
fi

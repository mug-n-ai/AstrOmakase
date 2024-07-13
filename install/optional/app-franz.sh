# Funzione per stampare messaggi di errore
print_error() {
    echo "[ERROR] $1" >&2
}

# Funzione per stampare messaggi di successo
print_success() {
    echo "[SUCCESS] $1"
}

echo "Installing dependencies..."
sudo apt install -y libx11-dev libxext-dev libxss-dev libxkbfile-dev
if [ $? -ne 0 ]; then
    print_error "Failed to install dependencies. Exiting."
    exit 1
fi

echo "Fetching the latest Franz release download link..."
LATEST_FRANZ_URL=$(curl -s https://api.github.com/repos/meetfranz/franz/releases/latest | grep "browser_download_url.*amd64.deb" | cut -d '"' -f 4)
if [ -z "$LATEST_FRANZ_URL" ]; then
    echo "Unable to fetch the latest Franz release download link. Exiting."
    exit 1
fi

echo "Downloading Franz..."
wget -O /tmp/franz.deb "$LATEST_FRANZ_URL"
if [ $? -ne 0 ]; then
    print_error "Failed to download Franz. Exiting."
    exit 1
fi

echo "Installing Franz..."
sudo apt install -y /tmp/franz.deb
if [ $? -ne 0 ]; then
    print_error "Failed to install Franz. Exiting."
    exit 1
fi

# Rimuovere il file .deb scaricato
echo "Cleaning up..."
rm /tmp/franz.deb
if [ $? -ne 0 ]; then
    print_error "Failed to remove temporary files."
else
    print_success "Removed temporary files."
fi

print_success "Franz installation script completed successfully."



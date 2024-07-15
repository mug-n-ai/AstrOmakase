SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"  


echo "Installing okular..."
sudo apt install -y okular
if [ $? -ne 0 ]; then
    print_error "Failed to install okular. Exiting."
    exit 1
fi
print_success "okular installed successfully."

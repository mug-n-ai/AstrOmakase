SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"  

echo "Installing GIMP..."
sudo apt install -y gimp
if [ $? -ne 0 ]; then
    print_error "Failed to install GIMP. Exiting."
    exit 1
fi
print_success "GIMP installed successfully."

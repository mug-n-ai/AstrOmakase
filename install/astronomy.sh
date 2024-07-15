SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"  

echo "Installing SAO DS9, FITSVerify, and FTOOLS FV..."
sudo apt install -y saods9 fitsverify ftools-fv
if [ $? -ne 0 ]; then
    print_error "Failed to install SAO DS9, FITSVerify, and FTOOLS FV. Exiting."
    exit 1
fi
print_success "SAO DS9, FITSVerify, and FTOOLS FV installed successfully."

echo "Installing Stellarium..."
sudo apt install -y stellarium
if [ $? -ne 0 ]; then
    print_error "Failed to install Stellarium. Exiting."
    exit 1
fi
print_success "Stellarium installed successfully."


echo "Installing Zotero..."
curl -sL https://raw.githubusercontent.com/retorquere/zotero-deb/master/install.sh | sudo bash
if [ $? -ne 0 ]; then
    print_error "Failed to install Zotero. Exiting."
    exit 1
fi
print_success "Zotero installed successfully."

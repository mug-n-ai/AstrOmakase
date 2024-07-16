SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh" 

echo "Checking if Slack is installed..."
if command_exists slack; then
    print_success "Slack is already installed. Skipping."
    exit 0
fi

echo "Installing Slack via Snap..."
sudo snap install slack --classic
if [ $? -ne 0 ]; then
    print_error "Failed to install Slack via Snap. Exiting."
    exit 1
fi
print_success "Slack installed successfully via Snap."

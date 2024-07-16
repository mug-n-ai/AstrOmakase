SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh" 

echo "Checking if Teams for Linux is installed..."
if command_exists teams-for-linux; then
    print_success "Teams for Linux is already installed. Skipping."
    exit 0
fi

echo "Creating directory for apt keyrings..."
sudo mkdir -p /etc/apt/keyrings
if [ $? -ne 0 ]; then
    print_error "Failed to create directory for apt keyrings. Exiting."
    exit 1
fi
print_success "Directory for apt keyrings created successfully."

echo "Downloading Teams for Linux GPG key..."
sudo wget -qO /etc/apt/keyrings/teams-for-linux.asc https://repo.teamsforlinux.de/teams-for-linux.asc
if [ $? -ne 0 ]; then
    print_error "Failed to download Teams for Linux GPG key. Exiting."
    exit 1
fi
print_success "Teams for Linux GPG key downloaded successfully."

echo "Adding Teams for Linux repository to sources list..."
echo "deb [signed-by=/etc/apt/keyrings/teams-for-linux.asc arch=$(dpkg --print-architecture)] https://repo.teamsforlinux.de/debian/ stable main" | sudo tee /etc/apt/sources.list.d/teams-for-linux-packages.list
if [ $? -ne 0 ]; then
    print_error "Failed to add Teams for Linux repository to sources list. Exiting."
    exit 1
fi
print_success "Teams for Linux repository added to sources list successfully."

echo "Updating package list..."
sudo apt update
if [ $? -ne 0 ]; then
    print_error "Failed to update package list. Exiting."
    exit 1
fi
print_success "Package list updated successfully."

echo "Installing Teams for Linux..."
sudo apt install -y teams-for-linux
if [ $? -ne 0 ]; then
    print_error "Failed to install Teams for Linux. Exiting."
    exit 1
fi
print_success "Teams for Linux installed successfully."

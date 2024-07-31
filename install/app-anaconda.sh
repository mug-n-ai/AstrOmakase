#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

check_anaconda_installed() {
    echo "Checking if Anaconda is already installed..."
    if [ -d "$HOME/anaconda3" ]; then
        echo "Anaconda directory exists. Checking if 'conda' command is available..."
        if command_exists conda; then
            print_success "Anaconda is already installed and 'conda' command is available."
        else
            handle_conda_not_found
        fi
    else
        install_anaconda
    fi
}

handle_conda_not_found() {
    print_error "Anaconda directory exists, but 'conda' command is not found."
    read -p "Do you want to attempt to repair the installation? (y/n): " response
    if [[ "$response" =~ ^[Yy]$ ]]; then
        repair_anaconda_installation
    else
        print_error "User chose not to repair the installation. Exiting."
        exit 1
    fi
}

repair_anaconda_installation() {
    echo "Attempting to repair the Anaconda installation by updating PATH..."
    export PATH="$HOME/anaconda3/bin:$PATH"
    # Add to .bashrc for permanence
    echo 'export PATH="$HOME/anaconda3/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    if command -v conda &> /dev/null; then
        print_success "'conda' command is now available."
        initialize_conda
    else
        print_error "Failed to repair Anaconda installation. Exiting."
        exit 1
    fi
}

install_anaconda() {
    echo "Downloading Anaconda installer..."
    wget -O /tmp/anaconda.sh https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-x86_64.sh
    if [ $? -ne 0 ]; then
        print_error "Failed to download Anaconda installer. Exiting."
        exit 1
    fi
    print_success "Anaconda installer downloaded successfully."

    echo "Installing Anaconda..."
    bash /tmp/anaconda.sh -b -p $HOME/anaconda3
    if [ $? -ne 0 ]; then
        print_error "Failed to install Anaconda. Exiting."
        exit 1
    fi
    print_success "Anaconda installed successfully."

    echo "Cleaning up..."
    rm /tmp/anaconda.sh
    if [ $? -ne 0 ]; then
        print_error "Failed to remove temporary files."
    else
        print_success "Removed temporary files."
    fi

    update_path_and_initialize_conda
}

update_path_and_initialize_conda() {
    echo "Updating PATH environment variable..."
    export PATH="$HOME/anaconda3/bin:$PATH"
    # Add to .bashrc for permanence
    echo 'export PATH="$HOME/anaconda3/bin:$PATH"' >> ~/.bashrc
    source ~/.bashrc
    if [ $? -ne 0 ]; then
        print_error "Failed to update PATH environment variable. Exiting."
        exit 1
    fi
    print_success "PATH environment variable updated."

    initialize_conda
}

initialize_conda() {
    echo "Initializing Conda..."
    conda init

    # Add priority to system PATH after conda init
    echo 'export PATH=/usr/bin:$PATH' >> ~/.bashrc
    source ~/.bashrc
}

update_conda() {
    echo "Updating Conda..."
    conda update -n base -c defaults conda -y
    if [ $? -ne 0 ]; then
        print_error "Failed to update Conda. Exiting."
        exit 1
    fi
    print_success "Conda updated successfully."
}

install_common_packages() {
    echo "Installing common packages..."
    conda install -n base numpy pandas matplotlib scipy astropy jupyter pip -y
    if [ $? -ne 0 ]; then
        print_error "Failed to install common packages. Exiting."
        exit 1
    fi
    print_success "Common packages installed successfully."
}

install_additional_packages() {
    echo "Installing additional packages..."
    conda install -n base h5py tqdm -y
    if [ $? -ne 0 ]; then
        print_error "Failed to install additional packages. Exiting."
        exit 1
    fi
    print_success "Additional packages installed successfully."
}

main() {
    check_anaconda_installed
    update_conda
    install_common_packages
    install_additional_packages
    echo "Anaconda installed and set up successfully."
}

main

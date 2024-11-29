#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"


# Function to check and delete Python installations in Mise
cleanup_mise_python() {
    # Directory where Mise installs are located
    MISE_INSTALLS_DIR="$HOME/.local/share/mise/installs/python"

    # Check if the directory exists
    if [ -d "$MISE_INSTALLS_DIR" ]; then
        # Check if there are any Python installations
        if [ "$(ls -A $MISE_INSTALLS_DIR)" ]; then
            gum confirm "This will delete all Python installations in Mise to make Anaconda the default Python environment manager and avoid conflicts. Do you want to proceed?" && {
                echo "Deleting Python installations in Mise..."
                # Remove all Python installations
                rm -rf "$MISE_INSTALLS_DIR"/*
                echo "All Python installations have been deleted from Mise."
            } || {
                echo "Operation cancelled by the user."
            }
        fi
    else
        echo "Mise installs directory for Python does not exist."
    fi
}

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


setting_default_conda_channels() {
    gump --yesno "Do you want to set default Conda channels?" --title "Conda Channels" --yes-label "Yes" --no-label "No"
    response=$?
    if [ $response -eq 0 ]; then
        conda config --add channels defaults
        if [ $? -ne 0 ]; then
            print_error "Failed to set default Conda channels. Exiting."
            exit 1
        fi
        print_success "Default Conda channels set successfully."
    fi
}

update_conda() {
    gump --yesno "Do you want to update Conda?" --title "Conda Update" --yes-label "Yes" --no-label "No"
    response=$?
    if [ $response -eq 0 ]; then
        echo "Updating Conda..."
        conda update -n base -c defaults conda -y
        if [ $? -ne 0 ]; then
            print_error "Failed to update Conda. Exiting."
            exit 1
        fi
        print_success "Conda updated successfully."
    else
        print_success "Skipped Conda update."
    fi
}

install_common_packages() {
    gump --yesno "Do you want to install common packages?" --title "Common Packages" --yes-label "Yes" --no-label "No"
    response=$?
    if [ $response -eq 0 ]; then
        conda install -n base numpy pandas matplotlib scipy astropy jupyter pip h5py tqdm -y
        if [ $? -ne 0 ]; then
            print_error "Failed to install common packages. Exiting."
            exit 1
        fi
        print_success "Common packages installed successfully."
    fi
}

main() {
    cleanup_mise_python
    check_anaconda_installed
    setting_default_conda_channels
    update_conda
    install_common_packages
    echo "Anaconda installed and set up successfully."
}

main

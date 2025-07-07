#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

# Function to check and delete Python installations in Mise
cleanup_mise_python() {
    local mise_installs_dir="$HOME/.local/share/mise/installs/python"

    print_info "Checking for Python installations in Mise..."
    if [ -d "$mise_installs_dir" ]; then
        if [ "$(ls -A "$mise_installs_dir")" ]; then
            print_info "Python installations found in Mise."
            if gum confirm "This will delete all Python installations in Mise to make Anaconda the default Python environment manager and avoid conflicts. Do you want to proceed?"; then
                print_info "Deleting Python installations in Mise..."
                if rm -rf "${mise_installs_dir:?}"/*; then
                    print_success "All Python installations have been deleted from Mise."
                else
                    print_error "Failed to delete Python installations from Mise."
                    return 1
                fi
            else
                print_info "Operation cancelled by the user. Skipping Mise Python cleanup."
            fi
        else
            print_success "No Python installations found in Mise. Skipping cleanup."
        fi
    else
        print_success "Mise installs directory for Python does not exist. Skipping cleanup."
    fi
    return 0
}

# Function to check if Anaconda is installed and conda command is available
is_anaconda_fully_installed() {
    if [ -d "$HOME/anaconda3" ] && command_exists conda; then
        return 0 # True
    else
        return 1 # False
    fi
}

# Function to add a line to .bashrc idempotently
add_line_to_bashrc_idempotent() {
    local line="$1"
    if ! grep -qF "$line" "$HOME/.bashrc"; then
        print_info "Adding line to ~/.bashrc: $line"
        echo "$line" >> "$HOME/.bashrc"
        return 0 # Line added
    else
        print_success "Line already exists in ~/.bashrc: $line"
        return 1 # Line already present
    fi
}

# Function to repair Anaconda installation if conda command is missing but directory exists
repair_anaconda_installation() {
    print_info "Anaconda directory exists, but 'conda' command is not found."
    if gum confirm "Do you want to attempt to repair the installation by updating PATH?"; then
        print_info "Attempting to repair the Anaconda installation by updating PATH..."
        add_line_to_bashrc_idempotent "export PATH=\"$HOME/anaconda3/bin:\$PATH\""
        # Source .bashrc for current session
        # shellcheck source=/dev/null
        source "$HOME/.bashrc"

        if command_exists conda; then
            print_success "'conda' command is now available after repair."
            initialize_conda
        else
            print_error "Failed to repair Anaconda installation. 'conda' command still not found."
            return 1
        fi
    else
        print_info "User chose not to repair the installation. Skipping Anaconda setup."
        return 1
    fi
    return 0
}

# Function to install Anaconda
install_anaconda() {
    print_info "Anaconda not found. Proceeding with installation."

    local anaconda_installer="/tmp/anaconda.sh"
    local anaconda_url="https://repo.anaconda.com/archive/Anaconda3-2024.06-1-Linux-x86_64.sh"

    if [ -f "$anaconda_installer" ]; then
        print_success "Anaconda installer already exists at $anaconda_installer. Skipping download."
    else
        print_info "Downloading Anaconda installer from $anaconda_url..."
        if ! wget -O "$anaconda_installer" "$anaconda_url"; then
            print_error "Failed to download Anaconda installer."
            return 1
        fi
        print_success "Anaconda installer downloaded successfully."
    fi

    print_info "Installing Anaconda to $HOME/anaconda3..."
    if ! bash "$anaconda_installer" -b -p "$HOME"/anaconda3; then
        print_error "Failed to install Anaconda."
        return 1
    fi
    print_success "Anaconda installed successfully."

    print_info "Cleaning up Anaconda installer..."
    if rm "$anaconda_installer"; then
        print_success "Anaconda installer removed successfully."
    else
        print_error "Failed to remove Anaconda installer."
    fi

    update_path_and_initialize_conda
    return 0
}

# Function to update PATH and initialize Conda
update_path_and_initialize_conda() {
    print_info "Updating PATH environment variable and initializing Conda..."
    add_line_to_bashrc_idempotent "export PATH=\"$HOME/anaconda3/bin:\$PATH\""

    # Source .bashrc for current session
    # shellcheck source=/dev/null
    source "$HOME/.bashrc"

    initialize_conda
    return 0
}

# Function to initialize Conda
initialize_conda() {
    print_info "Checking Conda initialization..."
    if grep -q "# >>> conda initialize >>>" "$HOME/.bashrc"; then
        print_success "Conda is already initialized in ~/.bashrc."
    else
        print_info "Initializing Conda..."
        if conda init bash; then
            print_success "Conda initialized successfully."
            # Source .bashrc again to apply conda init changes
            # shellcheck source=/dev/null
            source "$HOME/.bashrc"
        else
            print_error "Failed to initialize Conda."
            return 1
        fi
    fi
    return 0
}

# Function to set default Conda channels
setting_default_conda_channels() {
    print_info "Checking default Conda channels..."
    if conda config --show channels | grep -q "- defaults"; then
        print_success "Default Conda channels already set. Skipping."
    else
        if gum confirm "Do you want to set default Conda channels (defaults)?"; then
            print_info "Setting default Conda channels..."
            if conda config --add channels defaults; then
                print_success "Default Conda channels set successfully."
            else
                print_error "Failed to set default Conda channels."
                return 1
            fi
        else
            print_info "Skipped setting default Conda channels."
        fi
    fi
    return 0
}

# Function to update Conda
update_conda() {
    print_info "Checking for Conda updates..."
    # This check is a simplification; a true check would involve `conda update --dry-run`
    # For idempotency, we'll just ask the user if they want to update.
    if gum confirm "Do you want to update Conda (base environment)?"; then
        print_info "Updating Conda..."
        if conda update -n base -c defaults conda -y; then
            print_success "Conda updated successfully."
        else
            print_error "Failed to update Conda."
            return 1
        fi
    else
        print_info "Skipped Conda update."
    fi
    return 0
}

# Function to install common packages
install_common_packages() {
    print_info "Checking for common Conda packages..."
    # This check is a simplification; a true check would involve checking each package
    # For idempotency, we'll just ask the user if they want to install/update.
    if gum confirm "Do you want to install/update common Conda packages (numpy, pandas, matplotlib, scipy, astropy, jupyter, pip, h5py, tqdm)?"; then
        print_info "Installing common packages..."
        if conda install -n base numpy pandas matplotlib scipy astropy jupyter pip h5py tqdm -y; then
            print_success "Common packages installed successfully."
        else
            print_error "Failed to install common packages."
            return 1
        fi
    else
        print_info "Skipped installing common packages."
    fi
    return 0
}

main() {
    print_title "Setting up Anaconda..."

    cleanup_mise_python || return 1

    if is_anaconda_fully_installed; then
        print_success "Anaconda is already fully installed and configured. Skipping main installation steps."
    else
        if [ -d "$HOME/anaconda3" ]; then
            repair_anaconda_installation || return 1
        else
            install_anaconda || return 1
        fi
    fi

    setting_default_conda_channels || return 1
    update_conda || return 1
    install_common_packages || return 1

    print_success "Anaconda installation and setup process completed."
}

main

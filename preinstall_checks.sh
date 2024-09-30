#!/bin/bash

# Check if the running system is Ubuntu 24.04
if ! lsb_release -d | grep -q "Ubuntu 24.04"; then
    print_error "This script is designed for Ubuntu 24.04. Exiting."
    exit 1
fi


if $RUNNING_GNOME; then
	# Ensure computer doesn't go to sleep or lock while installing
	gsettings set org.gnome.desktop.screensaver lock-enabled false
	gsettings set org.gnome.desktop.session idle-delay 0
fi


OMAKUB_DIR="$HOME/.local/share/omakub"

if [ ! -d "$OMAKUB_DIR" ]; then
    echo "The default Omakub directory was not found."
    echo "For a better experience, we suggest starting with the Omakub installation."
    echo "Please check if the package is installed."
    read -p "Do you want to install Omakub now? (y/n): " response

    case "$response" in
        [yY]|[yY][eE][sS])
            echo "Omakub will be installed in $OMAKUB_DIR."
            echo "Note that you will be logged out at the end of the installation. To compleste Astromakase installation you will need to log back in and rerun the installation script."
            echo "Installing Omakub..."
            wget -qO- https://omakub.org/install | bash

            if [ $? -eq 0 ]; then
                echo "Omakub installed successfully."
                # Optionally, you can set OMAKUB_DIR here if the installation script does not do so
                # export OMAKUB_DIR="/path/to/omakub"
            else
                echo "Omakub installation failed. Please try installing manually."
                exit 1
            fi
            ;;
        [nN]|[nN][oO])
            echo "Proceeding without installing Omakub."
            ;;
        *)
            echo "Invalid response. Operation cancelled by the user."
            exit 1
            ;;
    esac
else
    if ! grep -q "hash -r" ~/.bashrc; then
        # fixing disabled hasing problem
        echo "hash -r" >> ~/.bashrc
    fi

fi

#!/bin/bash

CURRENT_VERSION=$(cat ~/.local/share/astromakase/version)

# Check if a previous version exists and migrate if necessary
if [ -f ~/.local/share/astromakase/version_previous ]; then
    PREVIOUS_VERSION=$(cat ~/.local/share/astromakase/version_previous | sed 's/^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/')
    echo "Previous version detected: $PREVIOUS_VERSION"
    echo "Preparing for migrating from version $PREVIOUS_VERSION to $CURRENT_VERSION..."    
    # Perform migration based on the previous version
    if [ "$PREVIOUS_VERSION" == "0.2.2" ]; then
        if dpkg -l | grep -q okular; then
            echo "Migrating Okular from apt to snap..."
            sudo apt purge okular -y
            sudo apt autoremove -y
            echo "Migration complete."
        fi
    fi
    if [ "$PREVIOUS_VERSION" == "0.2.5" ]; then
        if dpkg -l | grep -q okular; then
            echo "Migrating changing repository for speedtest..."
            sudo apt remove speedtest-cli -y
            sudo rm /etc/apt/sources.list.d/ookla_speedtest-cli.list
            sudo rm /etc/apt/keyrings/ookla_speedtest-cli-archive-keyring.gpg
            echo "Migration complete."
        fi
    fi 

    rm ~/.local/share/astromakase/version_previous
else
    echo "No previous version found. Fresh installation."
fi
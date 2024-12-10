#!/bin/bash

CURRENT_VERSION=$(cat ~/.local/share/astromakase/version)

# Check if a previous version exists and migrate if necessary
if [ -f ~/.local/share/astromakase/version_previous ]; then
    PREVIOUS_VERSION=$(cat ~/.local/share/astromakase/version_previous | sed 's/^\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/')
    echo "Previous version detected: $PREVIOUS_VERSION"
    echo "Preparing for migrating from version $PREVIOUS_VERSION to $CURRENT_VERSION..."    
    # Perform migration based on the previous version
    if [ "$PREVIOUS_VERSION" == "0.2.2" ]; then
        source "$INSTALL_DIR/migrations/from-0.2.2.sh"
    fi

    if [ "$PREVIOUS_VERSION" == "0.2.5" ]; then
        source "$INSTALL_DIR/migrations/from-0.2.5.sh"
    fi 

    if [ "$PREVIOUS_VERSION" == "0.2.7" ]; then
        source "$INSTALL_DIR/migrations/from-0.2.7.sh"
    fi 

    rm ~/.local/share/astromakase/version_previous
else
    echo "No previous version found. Fresh installation."
fi
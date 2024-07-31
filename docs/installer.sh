#!/bin/bash

# Function to fetch the latest stable release tag from GitHub
get_latest_release() {
    curl --silent "https://api.github.com/repos/LorenzoMugnai/AstrOmakase/releases/latest" | # Get latest release from GitHub API
    grep '"tag_name":' |                                                                    # Extract tag name line
    sed -E 's/.*"([^"]+)".*/\1/'                                                            # Extract only the tag name
}

# Fetch the latest stable release tag
LATEST_RELEASE=$(get_latest_release)

if [ -z "$LATEST_RELEASE" ]; then
    echo "Failed to fetch the latest release tag. Exiting."
    exit 1
fi

echo "Latest release: $LATEST_RELEASE"

# Construct the URL for the boot.sh script from the latest release
BOOT_URL="https://raw.githubusercontent.com/LorenzoMugnai/AstrOmakase/$LATEST_RELEASE/boot.sh"

echo "Downloading boot.sh from $BOOT_URL..."

# Download and execute the boot.sh script
wget -qO- $BOOT_URL | bash

if [ $? -ne 0 ]; then
    echo "Failed to download or execute the boot.sh script. Exiting."
    exit 1
fi

echo "boot.sh script executed successfully."

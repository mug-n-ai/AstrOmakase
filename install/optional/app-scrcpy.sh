#!/bin/bash


# Destination directory for the AppImage
APP_DIR="$HOME/Applications"
mkdir -p $APP_DIR

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing scrcpy..."

echo "Checking if scrcpy is installed..."
if command_exists scrcpy; then
    print_success "scrcpy is already installed. Skipping."
else
	echo "Installing dependencies..."
	sudo apt install -y ffmpeg libsdl2-2.0-0 adb wget \
		         gcc git pkg-config meson ninja-build libsdl2-dev \
		         libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev \
		         libswresample-dev libusb-1.0-0 libusb-1.0-0-dev
	if [ $? -ne 0 ]; then
	    print_error "Failed to install dependencies. Exiting."
	    exit 1
	fi
	print_success "Dependencies installed successfully."

	echo "Checking if scrcpy directory exists and is not empty..."
	if [ -d "$APP_DIR/scrcpy" ] && [ "$(ls -A $APP_DIR/scrcpy)" ]; then
	    echo "Directory exists and is not empty. Deleting directory..."
	    rm -rf "$APP_DIR/scrcpy"
	    if [ $? -ne 0 ]; then
		print_error "Failed to delete existing scrcpy directory. Exiting."
		exit 1
	    fi
	    print_success "Existing scrcpy directory deleted successfully."
	fi

	echo "Cloning scrcpy repository..."
	git clone https://github.com/Genymobile/scrcpy $APP_DIR/scrcpy
	if [ $? -ne 0 ]; then
	    print_error "Failed to clone scrcpy repository. Exiting."
	    exit 1
	fi
	print_success "scrcpy repository cloned successfully."


	echo "Installing scrcpy..."
	cd $APP_DIR/scrcpy
	source $APP_DIR/scrcpy/install_release.sh
	if [ $? -ne 0 ]; then
	    print_error "Failed to install scrcpy. Exiting."
	    exit 1
	fi
	print_success "scrcpy installed successfully."

	cd -
fi

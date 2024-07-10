sudo apt install -y ffmpeg libsdl2-2.0-0 adb wget \
                 gcc git pkg-config meson ninja-build libsdl2-dev \
                 libavcodec-dev libavdevice-dev libavformat-dev libavutil-dev \
                 libswresample-dev libusb-1.0-0 libusb-1.0-0-dev

cd ~/Applications

git clone https://github.com/Genymobile/scrcpy
cd scrcpy
bash ./install_release.sh

cd -

if dpkg -l | grep -q okular; then
    echo "Migrating changing repository for speedtest..."
    sudo apt remove speedtest-cli -y
    sudo rm /etc/apt/sources.list.d/ookla_speedtest-cli.list
    sudo rm /etc/apt/keyrings/ookla_speedtest-cli-archive-keyring.gpg
    echo "Migration complete."
fi
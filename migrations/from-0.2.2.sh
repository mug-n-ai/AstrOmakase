if dpkg -l | grep -q okular; then
    echo "Migrating Okular from apt to snap..."
    sudo apt purge okular -y
    sudo apt autoremove -y
    echo "Migration complete."
fi

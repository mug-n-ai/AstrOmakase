SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"


print_title "Migrating from 0.2.2..."

if dpkg -l | grep -q okular; then
    echo "Migrating Okular from apt to snap..."
    sudo apt purge okular -y
    sudo apt autoremove -y
    echo "Migration complete."
fi

print_success "Migration from 0.2.2 complete."

#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing GNOME Terminal theme..."

# shellcheck disable=SC1091
source "$SCRIPT_DIR/../themes/gnome-terminal/tokyo_night_gnome.sh"

print_success "GNOME Terminal theme setup completed."

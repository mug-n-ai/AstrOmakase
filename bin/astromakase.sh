#!/bin/bash

INSTALL_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

source "$INSTALL_DIR/ascii.sh"
echo "version $(cat $INSTALL_DIR/version)"

#!/bin/bash

# Definisci il percorso del browser (usa 'xdg-open' per aprire il browser predefinito)
BROWSER="xdg-open"

# Se non ci sono argomenti, apri il menu con gum
if [ $# -eq 0 ]; then
    CHOICE=$(gum choose "Update stable" "Update develop" "Visit GitHub" "Visit Website" "Quit" --height 10 --header "Choose an option:" | tr '[:upper:]' '[:lower:]')
else
    CHOICE=$1
fi

# Esegui l'azione in base alla scelta
case $CHOICE in
    "Update stable")
        echo "Updating the system installing the next stable version..."
        wget -qO- https://lorenzomugnai.github.io/AstrOmakase/installer.sh | bash
        ;;
    "Update develop")
        echo "Updating the system to the current develop version..."
        cd $INSTALL_DIR
        git pull
        source $INSTALL_DIR/install.sh
        ;;
    "visit github")
        echo "Opening GitHub..."
        $BROWSER "https://github.com/LorenzoMugnai/AstrOmakase"
        ;;
    "visit website")
        echo "Opening website..."
        $BROWSER "https://your-website-url.com"
        ;;
    *)
        echo "No valid option selected or exiting..."
        ;;
esac

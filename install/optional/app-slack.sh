#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../../common_functions.sh"

print_title "Installing Slack..."

local dependencies_slack=()
install_package "Slack" "slack" "slack" "snap" "dependencies_slack"

#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# shellcheck disable=SC1091
source "$SCRIPT_DIR/../common_functions.sh"

print_title "Installing libraries..."

# List of libraries to install
PACKAGES=(
  build-essential
  pkg-config
  autoconf
  bison
  clang
  rustc
  libssl-dev
  libreadline-dev
  zlib1g-dev
  libyaml-dev
  libreadline-dev
  libncurses5-dev
  libffi-dev
  libgdbm-dev
  libjemalloc2
  libvips
  imagemagick
  libmagickwand-dev
  mupdf
  mupdf-tools
  gir1.2-gtop-2.0
  gir1.2-clutter-1.0
  redis-tools
  sqlite3
  libsqlite3-0
  libmysqlclient-dev
  libpq-dev
  postgresql-client
  postgresql-client-common
  ubuntu-restricted-extras
  gnome-tweak-tool
  ffmpeg
)

for package in "${PACKAGES[@]}"; do
    apt_install "$package" || { print_error "Failed to install $package."; exit 1; }
done

print_success "All specified libraries installed successfully."

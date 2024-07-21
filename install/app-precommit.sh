#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/../common_functions.sh"

# Deactivate any active conda environment
echo "Deactivating any active conda environment..."
conda deactivate

# Install pre-commit
echo "Installing pre-commit..."
pip install pre-commit

# Check if pre-commit installation was successful
if ! command -v pre-commit &> /dev/null
then
    print_error "pre-commit could not be installed. Exiting."
    exit 1
fi

# Install pre-commit hooks
echo "Installing pre-commit hooks..."
pre-commit install

# Check if pre-commit hooks were installed successfully
if [ $? -ne 0 ]; then
    print_error "Failed to install pre-commit hooks. Exiting."
    exit 1
fi

# Reactivate the base conda environment
echo "Reactivating the base conda environment..."
conda activate

_success "Script completed successfully."

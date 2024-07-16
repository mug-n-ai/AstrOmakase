# Function to print error messages
print_error() {
    echo "[ERROR] $1" >&2
}

# Function to print success messages
print_success() {
    echo "[SUCCESS] $1"
}

# Function to check if a command exists
command_exists() {
    command -v "$1" &> /dev/null
}
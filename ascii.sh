#!/bin/bash

# Store the ASCII art as a list of individual lines
ascii_art=(
"  ___        _          _____                    _                      "
" / _ \      | |        |  _  |                  | |                     "
"/ /_\ \ ___ | |_  _ __ | | | | _ __ ___    __ _ | | __  __ _  ___   ___  "
"|  _  |/ __|| __|| '__|| | | || '_ \` _ \  / _\` || |/ / / _\` |/ __| / _ \ "
"| | | |\__ \| |_ | |   \ \_/ /| | | | | || (_| ||   < | (_| |\__ \|  __/ "
"\_| |_/|___/ \__||_|    \___/ |_| |_| |_| \__,_||_|\_\ \__,_||___/ \___| "
"                                                                       "
)

# Define the color gradient (shades of purple)
colors=(
    '\033[38;5;129m' # Medium Purple
    '\033[38;5;135m' # Light Purple
    '\033[38;5;141m' # Pale Purple
    '\033[38;5;147m' # Bright Purple
    '\033[38;5;183m' # Soft Magenta
    '\033[38;5;219m' # Pinkish Purple
    '\033[38;5;225m' # Light Magenta
)

# Reset color code
reset='\033[0m'

# Loop through each line of the ASCII art and print it with color
for i in "${!ascii_art[@]}"; do
    color_index=$((i % ${#colors[@]}))
    # Print each line with the corresponding color using printf
    printf "${colors[color_index]}%s${reset}\n" "${ascii_art[i]}"
done

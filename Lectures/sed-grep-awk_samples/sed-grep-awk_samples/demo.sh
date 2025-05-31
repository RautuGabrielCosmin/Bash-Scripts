#!/bin/bash

# Configuration
COMMANDS_FILE=${1-"ex1.txt"}
POEM_FILE=${2-"stanza.txt"}


# Verify files exist
if [[ ! -f "$COMMANDS_FILE" ]]; then
    echo "Error: $COMMANDS_FILE not found!" >&2
    exit 1
fi

if [[ ! -f "$POEM_FILE" ]]; then
    echo "Error: $POEM_FILE not found!" >&2
    exit 1
fi

# Clean up any previous terminal settings
stty sane

# Process each command
while IFS= read -r command || [[ -n "$command" ]]; do
    # Skip empty lines and comments
    [[ -z "$command" ]] && continue
    [[ "$command" =~ ^[[:space:]]*# ]] && continue

    clear
    
    # Display the poem
    echo "=== Contents of $POEM_FILE ==="
    cat "$POEM_FILE"
    echo -e "\n--------------------------"
    
    # Show the command to be executed
    echo -e "\nCommand to execute:"
    echo -e "\033[1;32m$command\033[0m"    
    read -rsn 1  < /dev/tty
    
    # # Execute the command
    echo -e "\n=== Command Output ==="
    eval "$command"
    echo -e "\n--------------------------"
    
    # Wait before continuing
    read -rsn 1  < /dev/tty
    echo
    
done < <(grep -v '^[[:space:]]*#' "$COMMANDS_FILE" | sed 's/\r$//')

echo "Demo complete!"
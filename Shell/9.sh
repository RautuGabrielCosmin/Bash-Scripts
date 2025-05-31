#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <username>"
  exit 1
fi

if ! id "$1" &>/dev/null; then
  echo "Error: user '$1' does not exist."
  exit 1
fi

count=$(pgrep -u "$1" | wc -l)
echo "Processes: $count"

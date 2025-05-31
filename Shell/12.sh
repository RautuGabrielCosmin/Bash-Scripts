#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

if [[ ! -d $1 ]]; then
  echo "Error: '$1' is not a directory."
  exit 1
fi

while IFS= read -r -d '' file; do
  if file "$file" | grep -q text; then
    echo "File: $file"
    head -n 3 "$file"
    echo
  fi
done < <(find "$1" -maxdepth 1 -type f -print0)

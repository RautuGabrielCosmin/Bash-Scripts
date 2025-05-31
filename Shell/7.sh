#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

if [[ ! -d $1 ]]; then
  echo "Error: '$1' is not a directory."
  exit 1
fi

total=0
while IFS= read -r -d '' file; do
  if file "$file" | grep -q text; then
    (( total += $(wc -l < "$file") ))
  fi
done < <(find "$1" -type f -print0)

echo "Total lines: $total"

#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

dir=$1
if [[ ! -d $dir ]]; then
  echo "Error: '$dir' is not a directory."
  exit 2
fi

while IFS= read -r -d '' f; do
  if file "$f" | grep -q text; then
    echo "----- $f -----"
    cat "$f"
  fi
done < <(find "$dir" -type f -print0)

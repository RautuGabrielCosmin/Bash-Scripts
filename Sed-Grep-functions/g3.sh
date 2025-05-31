#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <dir1> [dir2 ...]"
  exit 1
fi

for d in "$@"; do
  if [[ ! -d $d ]]; then
    echo "Error: '$d' is not a directory."
    continue
  fi
  find "$d" -type f -print0 | while IFS= read -r -d '' f; do
    if ! file "$f" | grep -q text; then
      echo "$f"
    fi
  done
done

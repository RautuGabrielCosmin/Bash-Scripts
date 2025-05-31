#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <file1> [file2 ...]"
  exit 1
fi

for f in "$@"; do
  if [[ ! -r $f ]]; then
    echo "Error: '$f' is not readable."
    continue
  fi
  grep -E '^[A-Z]+$' "$f"
done

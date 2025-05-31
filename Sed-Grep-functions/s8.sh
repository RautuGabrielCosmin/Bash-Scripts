#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <file1> [file2 ...]"
  exit 1
fi

for f in "$@"; do
  if [[ ! -f $f || ! -w $f ]]; then
    echo "Error: '$f' is not writable."
    continue
  fi
  awk -F':' 'BEGIN{OFS=":"} NF>=3 { $3=$1 } {print}' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
done

#!/bin/bash

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <text> <file1> [file2 ...]"
  exit 1
fi

text=$1
shift

for f in "$@"; do
  if [[ ! -f $f || ! -w $f ]]; then
    echo "Error: '$f' is not writable."
    continue
  fi
  grep -vF "$text" "$f" > "$f.tmp" && mv "$f.tmp" "$f"
done

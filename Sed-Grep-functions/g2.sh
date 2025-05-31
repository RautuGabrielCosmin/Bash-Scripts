#!/bin/bash

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <word> <file1> [file2 ...]"
  exit 1
fi

word=$1
shift
n=0

for f in "$@"; do
  if [[ ! -r $f ]]; then
    echo "Error: '$f' is not readable."
    continue
  fi
  if grep -qw -- "$word" "$f"; then
    echo "$f"
    ((n++))
  fi
done

echo "Total: $n"

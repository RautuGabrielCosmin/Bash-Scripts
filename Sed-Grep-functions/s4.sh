#!/bin/bash

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <uppercase_letter> <file1> [file2 ...]"
  exit 1
fi

letter=$1
shift

if [[ ! $letter =~ ^[A-Z]$ ]]; then
  echo "Error: first argument must be a single uppercase letter."
  exit 2
fi

for f in "$@"; do
  if [[ ! -f $f || ! -w $f ]]; then
    echo "Error: '$f' is not writable."
    continue
  fi
  sed -i "s/[a-z]/${letter}&/g" "$f"
done

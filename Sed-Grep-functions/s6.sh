#!/bin/bash

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <lowercase_letter> <file1> [file2 ...]"
  exit 1
fi

letter=$1
shift

if [[ ! $letter =~ ^[a-z]$ ]]; then
  echo "Error: first argument must be a single lowercase letter."
  exit 2
fi

for f in "$@"; do
  if [[ ! -f $f || ! -w $f ]]; then
    echo "Error: '$f' is not writable."
    continue
  fi
  sed -i "s/[^[:alnum:][:space:]]/$letter/g" "$f"
done

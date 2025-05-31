#!/bin/bash

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <file> <word1> [word2 ...]"
  exit 1
fi

file=$1
shift

if [[ ! -f $file || ! -w $file ]]; then
  echo "Error: '$file' is not writable."
  exit 2
fi

for w in "$@"; do
  [[ -z $w ]] && continue
  sed -i -E "s/\\b${w//\//\\/}\\b//g" "$file"
done

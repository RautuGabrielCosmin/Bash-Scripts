#!/bin/bash

if [[ $# -lt 2 ]]; then
  echo "Usage: $0 <names_file> <dir1> [dir2 ...]"
  exit 1
fi

names_file=$1
if [[ ! -r $names_file ]]; then
  echo "Error: '$names_file' is not readable."
  exit 2
fi
shift
mapfile -t names < "$names_file"

for d in "$@"; do
  if [[ ! -d $d ]]; then
    echo "Error: '$d' is not a directory."
    continue
  fi
  for n in "${names[@]}"; do
    [[ -z $n ]] && continue
    find "$d" -type f -name "$n" -exec rm -f {} +
  done
done

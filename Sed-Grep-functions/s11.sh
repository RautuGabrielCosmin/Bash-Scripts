#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <html_file>"
  exit 1
fi

file=$1
if [[ ! -r $file ]]; then
  echo "Error: '$file' is not readable."
  exit 2
fi

out="${file%.*}.txt"
sed -E 's/<[^>]+>//g' "$file" > "$out"
echo "Created $out"

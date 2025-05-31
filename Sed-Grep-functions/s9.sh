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
  awk '{
    out = ""
    for (i = 1; i <= NF; i++)
      if (i != 2 && i != 4)
        out = out ? out FS $i : $i
    print out
  }' "$f" > "$f.tmp" && mv "$f.tmp" "$f"
done

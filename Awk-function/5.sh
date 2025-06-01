#!/usr/bin/env bash

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <file1> [file2 ...]" >&2; exit 1; fi

for f in "$@"; do
  [[ -r $f ]] || { echo "Skip '$f' – unreadable" >&2; continue; }
  echo "── $f"
  count=0
  while IFS= read -r line; do
    if (( ${#line} > 10 )); then
      ((count++))
      printf "L%-4d %s\n" "$count" "${line:10}"
    fi
  done < "$f"
  printf "Total over-10-char lines: %d\n\n" "$count"
done

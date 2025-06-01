#!/usr/bin/env bash
if [[ $# -lt 1 ]]; then echo "Usage: $0 files..." >&2; exit 1; fi

files=0; total=0
for f in "$@"; do
  [[ -r $f ]] || { echo "Skip $f" >&2; continue; }
  ((files++))
  (( total += $(wc -w <"$f") ))
done
avg=$(awk -v t="$total" -v n="$files" 'BEGIN{printf "%.2f", n?t/n:0}')
echo "files: $files   avg words/file: $avg   total words: $total"

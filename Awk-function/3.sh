#!/usr/bin/env bash

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <file1> [file2 ...]" >&2; exit 1; fi

for f in "$@"; do
  [[ -r $f ]] || { echo "Skip '$f' – not readable" >&2; continue; }
  lc=$(tr -cd 'a-z' <"$f" | wc -c)
  uc=$(tr -cd 'A-Z' <"$f" | wc -c)
  ratio=$(awk -v l="$lc" -v u="$uc" \
          'BEGIN{printf (u? l/u : "∞")}')
  printf "%s l/u = %s/%s\n" "$f" "$lc" "$uc"
done

#!/usr/bin/env bash
shopt -s extglob
if [[ $# -lt 1 ]]; then echo "Usage: $0 files..." >&2; exit 1; fi

for f in "$@"; do
  [[ -r $f ]] || { echo "Skip $f" >&2; continue; }
  sum=0; with=0; without=0
  while IFS= read -r line; do
    nums=($(grep -oE '[0-9]+' <<<"$line"))
    if ((${#nums[@]})); then
      ((with++))
      for n in "${nums[@]}"; do ((sum+=n)); done
    else
      ((without++))
    fi
  done < "$f"
  printf "%s sum=%d   L1/L2=%d/%d\n" "$f" "$sum" "$with" "$without"
done

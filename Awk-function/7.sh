#!/usr/bin/env bash
if [[ $# -lt 1 ]]; then echo "Usage: $0 files..." >&2; exit 1; fi
for f in "$@"; do
  [[ -r $f ]] || { echo "Skip $f" >&2; continue; }
  nl -ba "$f" | while IFS=$'\t' read -r num line; do
    (( ${#line} < 20 )) && continue
    first=${line%% *}; last=${line##* }
    printf "%s:%d  %s ... %s\n" "$f" "$num" "$first" "$last"
  done
done

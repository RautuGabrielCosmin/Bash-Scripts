#!/usr/bin/env bash
if [[ $# -lt 1 ]]; then echo "Usage: $0 files..." >&2; exit 1; fi

for f in "$@"; do
  [[ -r $f ]] || { echo "Skip $f" >&2; continue; }
  nl -ba "$f" | while IFS=$'\t' read -r n l; do
    for w in $(tr -c 'A-Za-z' '\n' <<<"$l" | tr 'A-Z' 'a-z' | sort); do
      cnt=$(grep -o -i -w "$w" <<<"$l" | wc -l)
      ((cnt>=2)) && { printf "%s:%d %s\n" "$f" "$n" "$w"; break; }
    done
  done
done

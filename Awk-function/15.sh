#!/usr/bin/env bash
if [[ $# -lt 1 ]]; then echo "Usage: $0 files..." >&2; exit 1; fi

for f in "$@"; do
  [[ -r $f ]] || { echo "Skip $f" >&2; continue; }
  vow=$(tr -cd 'AEIOUaeiou' <"$f" | wc -c)
  con=$(tr -cd 'BCDFGHJKLMNPQRSTVWXYZbcdfghjklmnpqrstvwxyz' <"$f" | wc -c)
  printf "%s v/c = %d/%d\n" "$f" "$vow" "$con"
done

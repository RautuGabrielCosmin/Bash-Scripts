#!/usr/bin/env bash
if [[ $# -lt 1 ]]; then echo "Usage: $0 files..." >&2; exit 1; fi
bestfile=; bestcount=0
for f in "$@"; do
  [[ -r $f ]] || { echo "Skip $f" >&2; continue; }
  c=$(wc -w <"$f")
  if (( c > bestcount )); then bestcount=$c; bestfile=$f; fi
done
echo "Most-word file: $bestfile  words: $bestcount"

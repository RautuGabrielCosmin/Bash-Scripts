#!/usr/bin/env bash
# Detect lines where a word is immediately followed by
# the *same* word (case-insensitive).

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <file1> [file2 ...]" >&2; exit 1; fi

for f in "$@"; do
  nl -ba "$f" | \
  grep -Ei --only-matching \
       -n -e '(^|[^A-Za-z])([A-Za-z]+)[^A-Za-z]+\2([^A-Za-z]|$)' \
  | while IFS=: read -r num match; do
        word=$(sed -E 's/.*[^A-Za-z]([A-Za-z]+)[^A-Za-z]+\1.*/\1/I' <<<"$match")
        printf "%s:%d %s\n" "$f" "$num" "$word"
    done
done

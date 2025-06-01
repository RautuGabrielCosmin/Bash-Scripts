#!/usr/bin/env bash
if [[ $# -lt 3 ]]; then
  echo "Usage: $0 <old_word> <new_word> <file1> ..." >&2; exit 1; fi

old=$1 new=$2; shift 2
for f in "$@"; do
  [[ -w $f ]] || { echo "Skip $f – no write perms" >&2; continue; }
  # word boundaries via GNU sed \b
  sed -i -E "s/\b${old//\//\\/}\b/${new//\//\\/}/g" "$f"
done

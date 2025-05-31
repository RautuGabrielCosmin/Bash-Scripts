#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <user1> [user2 ...]"
  exit 1
fi

for u in "$@"; do
  if ! id "$u" &>/dev/null; then
    echo "Error: user '$u' does not exist."
    continue
  fi
  if ! last -w "$u" 2>/dev/null | grep -q "^$u"; then
    echo "$u"
  fi
done

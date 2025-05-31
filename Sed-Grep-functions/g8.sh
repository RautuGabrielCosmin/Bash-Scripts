#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <user1> [user2 ...]"
  exit 1
fi

logged=$(who | awk '{print $1}' | sort -u)

for u in "$@"; do
  if grep -qx "$u" <<< "$logged"; then
    echo "$u"
  fi
done

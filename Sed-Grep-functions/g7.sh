#!/bin/bash

if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <host1> [host2 ...]"
  exit 1
fi

for h in "$@"; do
  if ping -c 1 -W 2 "$h" &>/dev/null; then
    echo "$h"
  fi
done

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
  home=$(getent passwd "$u" | cut -d: -f6)
  [[ -z $home || ! -d $home ]] && { echo "No home for $u"; continue; }
  find "$home" -type d -perm -g=w -printf "$u: %p\n"
done

#!/usr/bin/env bash
# For a given group (e.g. gr821) print the group name and,
# beneath it, every member in “username  Full Name” format.

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <group>" >&2; exit 1; fi

group=$1
entry=$(getent group "$group") || {
  echo "Error: group '$group' not found" >&2; exit 2; }

IFS=: read -r _ _ _ members <<<"$entry"
echo "$group"
IFS=',' read -ra ulist <<<"$members"

for u in "${ulist[@]}"; do
  gecos=$(getent passwd "$u" | cut -d: -f5 | cut -d, -f1)
  printf "  %-12s %s\n" "$u" "${gecos:-<no-gecos>}"
done

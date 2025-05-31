#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <group_name>"
  exit 1
fi

group=$1
entry=$(getent group "$group")

if [[ -z $entry ]]; then
  echo "Error: group '$group' not found."
  exit 2
fi

IFS=':' read -r _ _ _ users <<< "$entry"
echo "$group"
if [[ -z $users ]]; then
  echo "No users."
else
  tr ',' '\n' <<< "$users"
fi

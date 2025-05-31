#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <group_id>"
  exit 1
fi

int_re='^[0-9]+$'
if ! [[ $1 =~ $int_re ]]; then
  echo "Error: argument must be a numeric group id."
  exit 1
fi

group_entry=$(getent group "$1")
if [[ -z $group_entry ]]; then
  echo "Error: group id '$1' not found."
  exit 1
fi

echo "$group_entry"

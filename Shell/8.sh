#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <user_file> <message_file>"
  exit 1
fi

if [[ ! -r $1 ]]; then
  echo "Error: '$1' is not readable."
  exit 1
fi

if [[ ! -r $2 ]]; then
  echo "Error: '$2' is not readable."
  exit 1
fi

while read -r user; do
  [[ -z $user ]] && continue
  mail -s "" "$user" < "$2"
done < "$1"

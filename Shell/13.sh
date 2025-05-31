#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <username>"
  exit 1
fi

username=$1
if (( ${#username} < 4 )); then
  echo "Error: username must be at least 4 characters long."
  exit 1
fi

section=${username:2:2}
digit_sum=0

for (( i=0; i<${#username}; i++ )); do
  ch=${username:i:1}
  if [[ $ch =~ [0-9] ]]; then
    (( digit_sum += ch ))
  fi
done

echo "Section: $section"
echo "Digit sum: $digit_sum"

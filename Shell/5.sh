#!/bin/bash

current_month=$(date '+%b')
current_year=$(date '+%Y')

while read -r username; do
  [[ -z $username ]] && continue
  if ! id "$username" &>/dev/null; then
    echo "User '$username' does not exist."
    continue
  fi
  count=$(last -w "$username" 2>/dev/null | awk -v m="$current_month" -v y="$current_year" '$0 ~ m && $0 ~ y && $NF != "in" {c++} END {print c+0}')
  if [[ $count -eq 0 ]]; then
    echo "User $username has never logged in during the current month"
  else
    echo "$username: $count"
  fi
done

#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <Mon> <day>"
  exit 1
fi

mon=$1
day=$2

if ! [[ $mon =~ ^(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)$ ]]; then
  echo "Error: invalid month."
  exit 2
fi
if ! [[ $day =~ ^[0-9]{1,2}$ ]]; then
  echo "Error: invalid day."
  exit 3
fi

log=/var/log/auth.log
if [[ ! -r $log ]]; then
  echo "Error: cannot read $log."
  exit 4
fi

grep "^$mon[[:space:]]*$day" "$log" | grep "session opened for user" \
 | awk '{for(i=1;i<=NF;i++) if($i=="user"){print $(i+1)}}' | sort -u

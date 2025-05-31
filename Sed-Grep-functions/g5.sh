#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <command_name>"
  exit 1
fi

cmd=$1
ps -eo user,comm | awk -v c="$cmd" '$2==c{print $1}' | sort -u

#!/bin/bash

if [[ $# -ne 0 ]]; then
  echo "Usage: $0"
  exit 1
fi

find . -type f -perm -g=w

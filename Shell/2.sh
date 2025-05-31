#!/bin/bash

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <file1> <file2>"
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

diff --old-line-format='%L' --new-line-format='%L' --unchanged-line-format='' "$1" "$2" | head -n 3

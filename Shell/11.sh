#!/bin/bash

echo "Sorted by name:"
find . -maxdepth 1 -type f -printf '%f\n' | sort

echo
echo "Sorted by last modified date:"
find . -maxdepth 1 -type f -printf '%T@ %f\n' | sort -nr | awk '{print $2}'

echo
echo "Sorted by size:"
find . -maxdepth 1 -type f -printf '%s %f\n' | sort -nr | awk '{print $2}'

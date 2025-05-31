#!/bin/bash

sum=0
int_re='^-?[0-9]+$'

while read -r num; do
  if ! [[ $num =~ $int_re ]]; then
    echo "Error: '$num' is not an integer. Try again."
    continue
  fi
  [[ $num -eq 0 ]] && break
  (( sum += num ))
done

echo "Sum: $sum"

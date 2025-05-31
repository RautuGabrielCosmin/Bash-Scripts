#!/bin/bash

if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <positive_integer>"
  exit 1
fi

int_re='^[0-9]+$'
if ! [[ $1 =~ $int_re ]]; then
  echo "Error: argument must be a positive integer."
  exit 1
fi

n=$1
if (( n < 2 )); then
  echo "$n is not prime"
  exit 0
fi

for (( i=2; i*i<=n; i++ )); do
  if (( n % i == 0 )); then
    echo "$n is not prime"
    exit 0
  fi
done

echo "$n is prime"

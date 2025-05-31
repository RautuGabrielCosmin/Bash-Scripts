#!/bin/bash

words=()

while read -r word; do
  [[ $word == stop ]] && break
  words+=("$word")
done

printf '%s\n' "${words[@]}"

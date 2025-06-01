#!/usr/bin/env bash
if [[ $# -ne 1 ]]; then
  echo "Usage: $0 <hh:mm-hh:mm>" >&2; exit 1; fi
IFS=':-' read -r h1 m1 h2 m2 <<<"$1"
range="1970-01-01 $h1:$m1:00 to 2037-12-31 $h2:$m2:00"

tot=0; days=0
# Take each day in wtmp
last -f /var/log/wtmp | grep -E '^[A-Za-z]{3}' \
| awk '{print $5,$6,$7}' | sort -u | while read -r mon day yr; do
    s=$(date -d "$yr-$mon-$day $h1:$m1" +%s)
    e=$(date -d "$yr-$mon-$day $h2:$m2" +%s)
    cnt=$(last -f /var/log/wtmp -s "@$s" -t "@$e" | grep -v "wtmp" | wc -l)
    ((tot+=cnt, days++))
done
avg=$(awk -v t="$tot" -v d="$days" 'BEGIN{printf "%.2f", d?t/d:0}')
echo "Avg users between $1 over $days days: $avg"

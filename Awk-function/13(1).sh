#!/usr/bin/env bash
# Params:  Mon  day  hh.mm-hh.mm   (e.g. Mar 8 11.00-12.00)

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <Mon> <day> <hh.mm-hh.mm>" >&2; exit 1; fi

mon=$1 day=$2 span=$3
IFS='-.' read -r h1 m1 h2 m2 <<<"$span"
year=$(date +%Y); monum=$(date -d "1 $mon $year" +%m)
start=$(printf "%04d-%02d-%02d %02d:%02d:00" "$year" "$monum" "$day" "$h1" "$m1")
stop=$(printf "%04d-%02d-%02d %02d:%02d:00" "$year" "$monum" "$day" "$h2" "$m2")

users=$(last -f /var/log/wtmp -s "$start" -t "$stop" \
        | awk '{print $1}' | grep -v '^$' | sort | uniq -c)

echo "Users $start → $stop"
echo "$users"
echo "Total users: $(awk '{s+=$1}END{print s}' <<<"$users")"

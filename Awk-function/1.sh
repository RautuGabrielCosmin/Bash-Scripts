#!/usr/bin/env bash
# ------------------------------------------------------------
#  For each 4-hour bucket of a given calendar day, print
#  the bucket label (hh:mm-hh:mm) and the *average* number
#  of users that were logged-in during that window, based
#  on /var/log/wtmp.  We approximate the average by sampling
#  the wtmp entries every minute in the interval.
# ------------------------------------------------------------

if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <Mon> <day(1-31)>" >&2
  exit 1
fi

month=$1            # e.g. Mar
day=$2              # e.g. 8
year=$(date +%Y)    # assume current year
wtmp=/var/log/wtmp
[[ -r $wtmp ]] || { echo "Error: cannot read $wtmp" >&2; exit 2; }

# Helper – translate month abbrev → month number
monum=$(date -d "1 $month $year" +%m 2>/dev/null) || {
  echo "Error: invalid month" >&2; exit 3; }

# Iterate over six 4-hour buckets
for start in 0 4 8 12 16 20; do
  end=$((start+4))
  from=$(printf "%04d-%02d-%02d %02d:00:00" "$year" "$monum" "$day" "$start")
  to=$(printf   "%04d-%02d-%02d %02d:00:00" "$year" "$monum" "$day" "$end")

  # Use 'last' to list sessions intersecting the window, then
  # sample the number of simultaneous sessions once per minute.
  samples=0; sum=0
  while read -r ts dir; do
      ((samples++))
      # How many sessions alive at this timestamp?
      alive=$(last -f "$wtmp" -R -s "$ts" -t "$ts" \
              | grep -v "wtmp begins" | wc -l)
      ((sum+=alive))
  done < <(seq 0 239 | while read -r m; do
               date -d "$from +$m min" '+%Y-%m-%d %H:%M:%S UTC'
           done | awk -v f="$from" -v t="$to" \
             '($0>=f && $0<t){print $0,"+"}')
  avg=$(awk -v s="$sum" -v n="$samples" 'BEGIN{printf "%.2f", n? s/n : 0}')
  printf "%02d:00-%02d:00  %s users (avg)\n" "$start" "$end" "$avg"
done

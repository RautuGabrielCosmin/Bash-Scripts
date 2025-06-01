#!/usr/bin/env bash
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 <file1> [file2 ...]" >&2; exit 1; fi

grand_total_words=0; grand_total_lines=0

for f in "$@"; do
  [[ -r $f ]] || { echo "Skip '$f'" >&2; continue; }
  words=$(wc -w <"$f"); lines=$(wc -l <"$f")
  avg=$(awk -v w="$words" -v l="$lines" 'BEGIN{printf "%.2f", l?w/l:0}')
  printf "%s  words:%d  lines:%d  avg_w/line:%s\n" \
         "$f" "$words" "$lines" "$avg"
  ((grand_total_words+=words, grand_total_lines+=lines))
done

overall=$(awk -v w="$grand_total_words" -v l="$grand_total_lines" \
             'BEGIN{printf "%.2f", l?w/l:0}')
echo "OVERALL average words/line: $overall"

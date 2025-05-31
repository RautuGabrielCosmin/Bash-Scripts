grep -E ',$' stanza.txt
grep -E '^Nu' stanza.txt	
grep -E '[aeiou]{2}.b[aeiou]\.$' stanza.txt	
grep -E 't....e' stanza.txt	
grep -E '[Nn]' stanza.txt	
grep -E 'i{2,4}' stanza.txt	
grep -E '[^a-z ]' stanza.txt	
grep -E 'e+' stanza.txt	
grep -E 'toa?t' stanza.txt	
grep -E 'a{1,2}' stanza.txt
grep -E '\<.?s[^ ]*e\>' stanza.txt
grep -E 'nc\>' stanza.txt
grep -Ei '\<([a-zăâîșț])([a-zăâîșț ]*)\1\>' stanza.txt
grep -E '[^\.]\.[\.]{2,}$|,$' stanza.txt



awk 'NF > 4' stanza.txt
awk 'length > 25' stanza.txt
awk '{print NR ". " $0}' stanza.txt
awk 'END{print FILENAME}' stanza.txt	
awk '{for(i=1;i<=NF;i++) if ($i ~ /ă\>/) print $i}' stanza.txt

awk 'NF >= 5' stanza.txt | sed 's/[aeiouăâîșțAEIOUȘȚĂÎÂ]/*/g' | grep -E '\*r'
awk 'NF >= 5' stanza.txt | sed -E 's/[aeiouăâîșțAEIOUȘȚĂÎÂ]/*/g' | grep -E '^(.).*\1$'
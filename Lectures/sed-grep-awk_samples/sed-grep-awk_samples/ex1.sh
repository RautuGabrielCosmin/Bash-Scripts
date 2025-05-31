sed 's/și/dar/g' stanza.txt
sed '2s/soarbe/stoarce/' stanza.txt
sed '$s/oarbe/negre/' stanza.txt
sed '/e.*e.*e/d' stanza.txt	
sed '2,3p' stanza.txt	
sed '/se.e/d' stanza.txt
sed -n '1,2p' stanza.txt	
sed $'3i\\\n---' stanza.txt
# echo $'3i\\\n---'
sed -f sedSkript_1.sh stanza.txt
sed $'$a\\\n---' stanza.txt	
sed 'y/aeiou/AEIOU/' stanza.txt	
sed 's/e/este/2' stanza.txt	
sed $'/nimic/{\np\ns/.*/---/\n}' stanza.txt


grep -i 'e' stanza.txt	
grep -v 'e' stanza.txt	
grep -n 'ene' stanza.txt	
grep -l 'senin|un' *	
grep -q 'totuși' stanza.txt	
grep -E 'un|o' stanza.txt
grep -E '\<a[a-z]+' stanza.txt


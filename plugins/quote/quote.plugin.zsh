if [[ -o interactive ]]; then
	local QUOTE=$(shuf -n1 $(dirname $0:a)/quotes.txt)
	local AUTHOR=$(echo $QUOTE | cut -d'|' -f1 | sed -e 's/^[[:space:]]*//' -e 's/*[[:space:]]//')
	local MESSAGE=$(echo $QUOTE | cut -d'|' -f2 | sed -e 's/^[[:space:]]*//' -e 's/*[[:space:]]//')

	echo $MESSAGE
	echo " - $AUTHOR"
fi

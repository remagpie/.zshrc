if [[ -o interactive ]]; then
	QUOTE=$(shuf -n1 $(dirname $0:a)/quotes.txt)
	AUTHOR=$(echo $QUOTE | cut -d'|' -f1 | sed -e 's/^[[:space:]]*//' -e 's/*[[:space:]]//')
	MESSAGE=$(echo $QUOTE | cut -d'|' -f2 | sed -e 's/^[[:space:]]*//' -e 's/*[[:space:]]//')

	echo $MESSAGE
	echo " - $AUTHOR"
fi

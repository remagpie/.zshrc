if [[ -o interactive ]]; then
	local QUOTEDB="$(dirname $0:a)/quotes.txt"
	local ROW
	case $OSTYPE in
		linux*)
			ROW=$(shuf -n1 $QUOTEDB)
			;;
		darwin*)
			ROW=$(gshuf -n1 $QUOTEDB)
			;;
	esac
	local AUTHOR=$(echo $ROW | cut -d'|' -f1 | sed -e 's/^[[:space:]]*//' -e 's/*[[:space:]]//')
	local MESSAGE=$(echo $ROW | cut -d'|' -f2 | sed -e 's/^[[:space:]]*//' -e 's/*[[:space:]]//')

	echo $MESSAGE
	echo " - $AUTHOR"
fi

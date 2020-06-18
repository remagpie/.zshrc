function _title__set_title {
	case $TERM in
		xterm*)
			print -Pn "\e]1;$1:q\a"
			print -Pn "\e]2;$1:q\a"
			;;
		*)
			# Do nothing
			;;
	esac
}

function _title__precmd {
	_title__set_title "zsh :: $(print -P %~)"
}

function _title__preexec {
	_title__set_title "$1 :: $(print -P %~)"
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd _title__precmd
add-zsh-hook preexec _title__preexec

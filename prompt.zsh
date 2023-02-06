setopt PROMPT_SUBST
setopt MULTIBYTE
zmodload zsh/datetime

# autoload -Uz colors && colors
declare -A __fg
__reset_color="%{\e[0m%}"
__fg[black]="%{\e[30m%}"
__fg[red]="%{\e[31m%}"
__fg[green]="%{\e[32m%}"
__fg[yellow]="%{\e[33m%}"
__fg[blue]="%{\e[34m%}"
__fg[magenta]="%{\e[35m%}"
__fg[cyan]="%{\e[36m%}"
__fg[white]="%{\e[37m%}"
__fg[br-black]="%{\e[90m%}"
__fg[br-red]="%{\e[91m%}"
__fg[br-green]="%{\e[92m%}"
__fg[br-yellow]="%{\e[93m%}"
__fg[br-blue]="%{\e[94m%}"
__fg[br-magenta]="%{\e[95m%}"
__fg[br-cyan]="%{\e[96m%}"
__fg[br-white]="%{\e[97m%}"
__newline=$'\n'

__prompt() {
	local __result=""
	local __left=""
	local __left_columns=0
	local __right=""
	local __right_columns=0
	local __line=""

	# __result+="[$__fg[red]%n$__reset_color]"
	local __pwd=${PWD/#$HOME/'~'}
	__left+="$__fg[cyan]"
	__left+="$__pwd"
	__left_columns=$(( __left_columns + ${(m)#__pwd} ))

	local __datetime=$(strftime "%I:%M:%S %p")
	__right+="$__fg[br-blue]"
	__right+="$__datetime"
	__right_columns=$(( __right_columns + ${(m)#__datetime} ))

	if (( $COLUMNS >= $__left_columns + 1 + $__right_columns )); then
		__line="$__left${(l:($COLUMNS - $__left_columns - $__right_columns):: :)}$__right"
	elif (( $COLUMNS >= $__left_columns )); then
		__line="$__left${(l:($COLUMNS - $__left_columns):: :)}"
	else
		__line="$__left"
	fi
	__result="$__result$__line$__newline$__reset_color"
	__left=""
	__left_columns=0
	__right=""
	__right_columns=0

	__left+="$__fg[magenta]"
	__left+=">"
	__left_columns=$(( __left_columns + 1 ))

	__result="$__result$__left$__reset_color "

	echo "$__result"
}
__rprompt() {
	local __result=""
	__result+="$__reset_color [$__fg[yellow]%?$__reset_color]"
	echo "$__result"
}

PROMPT='$(__prompt)'
RPROMPT='$(__rprompt)'

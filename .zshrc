# Bootstrap zgen
if ! [ -e "${ZDOTDIR}/zgen" ]; then
	git clone https://github.com/tarjoilija/zgen.git ${ZDOTDIR}/zgen
fi

ZGEN_DIR="${ZDOTDIR}/zgen"
ZGEN_AUTOLOAD_COMPINIT=0
source ${ZDOTDIR}/zgen/zgen.zsh

if ! zgen saved; then
	zgen load zsh-users/zsh-autosuggestions
	zgen load zsh-users/zsh-syntax-highlighting
	zgen load ${ZDOTDIR}/plugins/quote
	zgen load ${ZDOTDIR}/plugins/title
	zgen load ${ZDOTDIR}/plugins/zhooks
	zgen save
fi

# Make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
        function zle-line-init () {
                echoti smkx
        }
        function zle-line-finish () {
                echoti rmkx
        }
        zle -N zle-line-init
        zle -N zle-line-finish
fi

autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

disable r

typeset -A key
key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"

bindkey -v
[[ -n "${key[Home]}"   ]] && bindkey "${key[Home]}"   beginning-of-line
[[ -n "${key[End]}"    ]] && bindkey "${key[End]}"    end-of-line
[[ -n "${key[Delete]}" ]] && bindkey "${key[Delete]}" delete-char
[[ -n "${key[Up]}"     ]] && bindkey "${key[Up]}"     up-line-or-beginning-search
[[ -n "${key[Down]}"   ]] && bindkey "${key[Down]}"   down-line-or-beginning-search
[[ -n "${key[Left]}"   ]] && bindkey "${key[Left]}"   backward-char
[[ -n "${key[Right]}"  ]] && bindkey "${key[Right]}"  forward-char

setopt autopushd pushdignoredups pushdminus pushdsilent pushdtohome
DIRSTACKSIZE=20

setopt listrowsfirst
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

autoload -Uz colors && colors
NEWLINE=$'\n'
PROMPT="[%{$fg[red]%}%n%{$reset_color%}]%{$fg[cyan]%}%~${NEWLINE}%{$reset_color%}%{$fg[magenta]%}%#%{$reset_color%}"
RPROMPT="[%{$fg_no_bold[yellow]%}%?%{$reset_color%}]"

setopt histignoredups incappendhistory
HISTFILE="${ZDOTDIR}/.zshhist"
HISTSIZE=1000
SAVEHIST=1000

REPORTTIME=20

function calc() {
	echo "$@" | bc -l | sed -E 's/([1-9])0+$/\1/' | sed -E 's/\.0+$//' | sed -E 's/^\./0\./'
}

export EDITOR=nvim
export GIT_PAGER='less -R -X -F'

case $OSTYPE in
	linux*)
		alias ls='ls --color=auto'
		alias diff='diff --color=auto'
		alias grep='grep --color=auto'
		alias egrep='egrep --color=auto'
		alias fgrep='fgrep --color=auto'
		;;
	darwin*)
		if [ -x $(command -v gls) ]; then
			alias ls='gls --color=auto'
		else
			alias ls='ls -G'
		fi
		;;
esac
	echo "$@"
aliases[=]="noglob calc"

export PATH="$HOME/.local/bin:$PATH"

if [ -d "$HOME/.cargo" ]; then
	source ~/.cargo/env
fi

if [ -d "$HOME/.fnm" ]; then
	export PATH="$HOME/.fnm:$PATH"
	eval "`fnm env`"
fi

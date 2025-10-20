# Bootstrap zgen
if ! [ -e "${ZDOTDIR}/zgen" ]; then
	git clone https://github.com/tarjoilija/zgen.git ${ZDOTDIR}/zgen
fi

case $OSTYPE in
	darwin*)
		eval "$(/opt/homebrew/bin/brew shellenv)"
		;;
esac
export PATH="$HOME/.local/bin:$PATH"

ZGEN_DIR="${ZDOTDIR}/zgen"
ZGEN_AUTOLOAD_COMPINIT=0
source ${ZDOTDIR}/zgen/zgen.zsh


if ! zgen saved; then
	zgen load zsh-users/zsh-autosuggestions
	zgen load zsh-users/zsh-syntax-highlighting
	zgen load ${ZDOTDIR}/plugins/git
	zgen load ${ZDOTDIR}/plugins/history
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

source ${ZDOTDIR}/bindings.zsh
source ${ZDOTDIR}/prompt.zsh

setopt autopushd pushdignoredups pushdminus pushdsilent pushdtohome
DIRSTACKSIZE=20

setopt listrowsfirst
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select

function calc() {
	echo "$@" | bc -l | sed -E 's/([1-9])0+$/\1/' | sed -E 's/\.0+$//' | sed -E 's/^\./0\./'
}

export EDITOR=nvim

function __fallback_cmd {
	local arg
	for arg in $@; do
		local cmd=${arg%% *}
		if command -v $cmd &> /dev/null; then
			echo "$arg"
			break
		fi
	done
}

case $OSTYPE in
	linux*)
		alias l="$(__fallback_cmd	'lsd'		'ls --color')"
		alias la="$(__fallback_cmd	'lsd -A'	'ls --color -A')"
		alias ll="$(__fallback_cmd	'lsd -l'	'ls --color -lh')"
		alias lla="$(__fallback_cmd	'lsd -lA'	'ls --color -lhA')"
		alias ls='ls --color=auto'
		alias diff='diff --color=auto'
		alias grep='grep --color=auto'
		alias egrep='egrep --color=auto'
		alias fgrep='fgrep --color=auto'

		function open() {
			( nohup xdg-open "$@" > /dev/null 2>&1 & )
		}
		;;
	darwin*)
		alias l="$(__fallback_cmd	'lsd'		'gls --color'		'ls -G')"
		alias la="$(__fallback_cmd	'lsd -A'	'gls --color -A'	'ls -Ga')"
		alias ll="$(__fallback_cmd	'lsd -l'	'gls --color -lh'	'ls -Gl')"
		alias lla="$(__fallback_cmd	'lsd -lA'	'gls --color -lhA'	'ls -Gla')"
		alias ls="$(__fallback_cmd	'gls --color=auto'	'ls -G')"
		;;
esac
aliases[=]="noglob calc"

export PATH="$HOME/.local/bin:$PATH"

if [ -d "$HOME/.cargo" ]; then
	source ~/.cargo/env
fi

case $OSTYPE in
	linux*) if [ -d "$HOME/.local/share/fnm" ]; then eval "`$HOME/.local/share/fnm/fnm env`"; fi;;
	darwin*) if type fnm > /dev/null; then eval "`fnm env`"; fi;;
esac

if [ -d "$HOME/.elan" ]; then
	source "$HOME/.elan/env"
fi

if type zoxide > /dev/null; then
	_ZO_DATA_DIR="${ZDOTDIR}/.zoxide"
	_ZO_MAXAGE=10000
	eval "$(zoxide init --cmd j zsh)"
fi

if type claude > /dev/null; then
	alias claude='claude --continue'
fi

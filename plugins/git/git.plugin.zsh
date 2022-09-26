alias g="git"

__GITCONFIG_PATH=$HOME/.gitconfig
if ! grep -zq '# Automatically added by zsh git plugin\s\s*\[include\]' $__GITCONFIG_PATH; then
	echo '' >> $__GITCONFIG_PATH
	echo '# Automatically added by zsh git plugin' >> $__GITCONFIG_PATH
	echo '[include]' >> $__GITCONFIG_PATH
	echo "\tpath = ${0:A:h}/gitconfig.static" >> $__GITCONFIG_PATH
fi
unset __GITCONFIG_PATH

__GITCONFIG_DYN=""
__GITCONFIG_DYN+="[core]\n"
if command -v delta &> /dev/null; then
	__GITCONFIG_DYN+="\tpager = delta\n"
	__GITCONFIG_DYN+="[interactive]\n"
	__GITCONFIG_DYN+="\tdiffFilter = delta --color-only\n"
else
	__GITCONFIG_DYN+="\tpager = less -R -X -F\n"
fi
__GITCONFIG_DYN_PATH=${0:A:h}/gitconfig.dynamic
if ! [ "$__GITCONFIG_DYN" = "$(cat $__GITCONFIG_DYN_PATH)" ]; then
	echo "$__GITCONFIG_DYN" > $__GITCONFIG_DYN_PATH
fi
unset __GITCONFIG_DYN_PATH
unset __GITCONFIG_DYN

alias g="git"

export GIT_PAGER='less -R -X -F'
if ! grep -zq '# Automatically added by zsh git plugin\s\s*\[include\]' $HOME/.gitconfig; then
	echo '' >> $HOME/.gitconfig
	echo '# Automatically added by zsh git plugin' >> $HOME/.gitconfig
	echo '[include]' >> $HOME/.gitconfig
	echo "\tpath = ${0:A:h}/gitconfig" >> $HOME/.gitconfig
fi

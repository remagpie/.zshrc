declare -A key
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

bindkey -N remagpie .safe
bindkey -M remagpie -R "^@"-"\M-^?" self-insert
bindkey -M remagpie "^J" accept-line
bindkey -M remagpie "^M" accept-line

bindkey -M remagpie "^H" backward-char
bindkey -M remagpie "^I" expand-or-complete
bindkey -M remagpie "^L" clear-screen
bindkey -M remagpie "^M" accept-line
bindkey -M remagpie "^U" kill-whole-line
bindkey -M remagpie "^V" quoted-insert
bindkey -M remagpie "^W" backward-kill-word
bindkey -M remagpie "^?" backward-delete-char
bindkey -M remagpie "^[[200~" bracketed-paste

[[ -n "${key[Home]}"   ]] && bindkey -M remagpie "${key[Home]}"   beginning-of-line
[[ -n "${key[End]}"    ]] && bindkey -M remagpie "${key[End]}"    end-of-line
[[ -n "${key[Delete]}" ]] && bindkey -M remagpie "${key[Delete]}" delete-char
[[ -n "${key[Up]}"     ]] && bindkey -M remagpie "${key[Up]}"     up-line-or-beginning-search
[[ -n "${key[Down]}"   ]] && bindkey -M remagpie "${key[Down]}"   down-line-or-beginning-search
[[ -n "${key[Left]}"   ]] && bindkey -M remagpie "${key[Left]}"   backward-char
[[ -n "${key[Right]}"  ]] && bindkey -M remagpie "${key[Right]}"  forward-char
bindkey -M remagpie "^[[1;3D" backward-word
bindkey -M remagpie "^[[1;3C" forward-word

bindkey -M remagpie "^J" backward-char
bindkey -M remagpie "^L" forward-char
bindkey -M remagpie "^[j" backward-word
bindkey -M remagpie "^[l" forward-word
bindkey -M remagpie "^[i" up-line-or-beginning-search
bindkey -M remagpie "^[k" down-line-or-beginning-search

bindkey -A remagpie main

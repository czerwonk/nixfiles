zmodload -i zsh/complist

setopt hist_find_no_dups
setopt complete_in_word

_force_rehash() { (( CURRENT == 1 )) && rehash return 1 }

zstyle ':completion:*'                    completer _extensions _complete _approximate _force_rehash
zstyle ':completion:*'                    group-name ''
zstyle ':completion:*'                    list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*'                    matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*'                    menu select
zstyle ':completion:*'                    special-dirs ..
zstyle ':completion:*'                    use-cache yes
zstyle ':completion:*:complete:*'         cache-path '~/.zcomp.cache'
zstyle ':completion:*'                    verbose true
zstyle ':completion:*:*:-subscript-:*'    tag-order indexes parameters
zstyle ':completion:*:*:zcompile:*'       ignored-patterns '(*~|*.zwc)'
zstyle ':completion:*:-command-:*:'       verbose false
zstyle ':completion:*:expand:*'           tag-order all-expansions
zstyle ':completion:*:git-checkout:*'     sort false
zstyle ':completion:*:history-words'      stop yes
zstyle ':completion:*:history-words'      remove-all-dups yes
zstyle ':completion:*:history-words'      menu yes
zstyle ':completion:*:history-words'      list false
zstyle ':completion:*:man:*'              menu yes select
zstyle ':completion:*:manuals'            insert-sections true
zstyle ':completion:*:manuals'            separate-sections true
zstyle ':completion:*:matches'            group 'yes'
zstyle ':completion:*:options'            auto-description %d
zstyle ':completion:*:options'            description yes
zstyle ':completion:*:processes'          command 'ps -au$USER'
zstyle ':completion:*:processes-names'    command 'ps c -u ${USER} -o command | uniq'
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
zstyle ':completion:*:kill:*'             command 'ps xf -u $USER -o pid,%cpu,cmd'

## formating
zstyle ':completion:*:messages'     format '%d'
zstyle ':completion:*:corrections'  format '%B%F{yellow}%d (errors: %e)%f%b'
zstyle ':completion:*:descriptions' format '%B%F{green}# %d%f%b'
zstyle ':completion:*:warnings'     format '%B%F{red}No matches for: %d%f%b'

## correction
zstyle ':completion:*:correct:*'                  insert-unambiguous true
zstyle ':completion:correct:'                     prompt 'correct to: %e'
zstyle ':completion:correct:'                     prompt 'correct to: %e'
zstyle ':completion::(^approximate*):*:functions' ignored-patterns '_*'
zstyle ':completion:*:correct:*'                  original true

## keybindings
bindkey -M menuselect '/' history-incremental-search-forward
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -M menuselect 'l' vi-forward-char

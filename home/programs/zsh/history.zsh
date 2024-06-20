setopt hist_find_no_dups

autoload -U history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "${terminfo[kcuu1]}" history-beginning-search-backward-end
bindkey "${terminfo[kcud1]}" history-beginning-search-forward-end
bindkey '^p'   history-search-backward
bindkey '^n'   history-search-forward

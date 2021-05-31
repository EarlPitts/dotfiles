#!/usr/bin/zsh

bindkey -v                                      # Vim keybindings

bindkey '^ ' autosuggest-accept
bindkey -v '^?' backward-delete-char            # Backspace stuck in vim mode

zle -N ref
zle -N prod
bindkey  '^u' ref
bindkey  '^o' prod

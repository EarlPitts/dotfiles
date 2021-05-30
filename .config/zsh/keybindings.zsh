#!/usr/bin/zsh

bindkey -v                                      # Vim keybindings

bindkey '^ ' autosuggest-accept
bindkey -v '^?' backward-delete-char           # Backspace stuck in vim mode

bindkey -s '^u' 'references\n'
bindkey -s '^o' 'productivity\n'

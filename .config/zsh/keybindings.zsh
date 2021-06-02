#!/usr/bin/zsh

bindkey -v                                      # Vim keybindings

bindkey '^ ' autosuggest-accept
bindkey -v '^?' backward-delete-char            # Backspace stuck in vim mode

bindkey -s '^u' 'references^M'
bindkey -s '^o' 'productivity^M'
#bindkey -s '^i' 'quick_note open^M'

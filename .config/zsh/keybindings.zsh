#!/usr/bin/zsh

bindkey -v                                      # Vim keybindings

bindkey '^ ' autosuggest-accept
bindkey -v '^?' backward-delete-char            # Backspace stuck in vim mode

# Pressing ^Z a second time will bring back
# the process from the background
_zsh_cli_fg() { fg; }
zle -N _zsh_cli_fg
bindkey '^Z' _zsh_cli_fg

# bindkey -s '^u' 'references^M'
# bindkey -s '^o' 'productivity^M'
#bindkey -s '^i' 'quick_note open^M'

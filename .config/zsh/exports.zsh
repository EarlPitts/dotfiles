# Default editors
export EDITOR='nvim'
export VEDITOR='code'

# Indexes
# TODO Add some frequently accessed files to my env?
#export NOTES=$HOME"/Personal/Inbox/index.md"

# Path
export PATH=$PATH:~/.local/bin

export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!**/.git/*' --glob '!.venv/*' --glob '!__pycache__/*'"

export KEYTIMEOUT=1
export TERM=xterm-256color # for tmux

# Colored Manpages
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=base16'"
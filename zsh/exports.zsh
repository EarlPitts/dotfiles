# default editors
export EDITOR='nvim'
export VEDITOR='code'

# Path
export PATH=$PATH:~/.scripts
export PATH=$PATH:~/.local/bin

export FZF_DEFAULT_COMMAND='rg --files --no-ignore --hidden --follow --glob "!.git/*" --glob "!venv/*"'

export KEYTIMEOUT=1
export TERM=xterm-256color # for tmux

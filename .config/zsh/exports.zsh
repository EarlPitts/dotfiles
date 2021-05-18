# Default editors
export EDITOR='nvim'
export VEDITOR='code'

# References
WIKI="$HOME/Personal/Notes"
WORK_WIKI="$HOME/Work/Notes"
SNIPPETS="$HOME/Personal/Snippets"

# Indexes
# TODO Add some frequently accessed files to my env?
#export NOTES=$HOME"/Personal/Inbox/index.md"
export NOTES=$HOME/Personal/Notes
export WORK_NOTES=$HOME/Work/Notes

# Path
export PATH=$PATH:~/.local/bin

export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!**/.git/*' --glob '!.venv/*' --glob '!__pycache__/*'"

export KEYTIMEOUT=1
export TERM=xterm-256color # for tmux

# Colored Manpages
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=base16'"

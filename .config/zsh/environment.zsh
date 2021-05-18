# Default editors
export EDITOR='nvim'
export VEDITOR='code'

# References
export WIKI="$HOME/Personal/Notes"
export WORK_WIKI="$HOME/Work/Notes"
export SNIPPETS="$HOME/Personal/Snippets"

# Productivity
export PROJECTS="$HOME/Projects"
export WORK_AREAS="$HOME/Work/Areas"
export AREAS="$HOME/Personal/Direction"
export TASKLIST="$HOME/Personal/tasks.md"
export WORK_TASKLIST="$HOME/Work/tasks.md"
export WAITING="$HOME/Personal/waiting.md"
export WORK_WAITING="$HOME/Work/waiting.md"
export CHECKLISTS="$HOME/Personal/Checklists"

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

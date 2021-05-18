# Default editors
export EDITOR='nvim'
export VEDITOR='code'

# References
export WIKI="$HOME/Personal/Wiki"
export WORK_WIKI="$HOME/Work/Wiki"
export SNIPPETS="$HOME/Personal/Snippets"
export BOOKS=$HOME/Personal/References/Books
export CHEATSHEETS=$HOME/Personal/References/Cheatsheets
export PAPERS=$HOME/Personal/References/Papers

# Productivity
export PROJECTS="$HOME/Projects"
export WORK_AREAS="$HOME/Work/Areas"
export AREAS="$HOME/Personal/Areas"
export TASKLIST="$HOME/Personal/tasks.md"
export WORK_TASKLIST="$HOME/Work/tasks.md"
export WAITING="$HOME/Personal/waiting.md"
export WORK_WAITING="$HOME/Work/waiting.md"
export CHECKLISTS="$HOME/Personal/Checklists"

# Path
export PATH=$PATH:~/.local/bin

export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!**/.git/*' --glob '!.venv/*' --glob '!__pycache__/*'"

export KEYTIMEOUT=1
export TERM=xterm-256color # for tmux

# Colored Manpages
export MANPAGER="sh -c 'col -bx | bat -l man -p --theme=base16'"

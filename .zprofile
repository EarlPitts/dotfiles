# Default editors
export EDITOR='nvim'
export VEDITOR='code'

export PERSONAL="$HOME/Personal"
export WORK="$HOME/Work"

# References
export WIKI="$WORK/Wiki"
export WORK_WIKI="$WORK/Wiki"
export SNIPPETS="$PERSONAL/Snippets"
export BOOKS=$PERSONAL/References/Books
export CHEATSHEETS=$PERSONAL/References/Cheatsheets
export PAPERS=$PERSONAL/References/Papers

# Productivity

if [ "$(uname -n)" = "work" ]; then
    export CALENDAR="$WORK/calendar"
    export CALENDAR_ALT="$PERSONAL/calendar"
    export AREAS="$WORK/Areas"
    export AREAS_ALT="$PERSONAL/Areas"
    export INBOX_ALT=$PERSONAL/Inbox/index.md
    export INBOX=$WORK/Inbox/index.md
else
    export CALENDAR="$PERSONAL/calendar"
    export CALENDAR_ALT="$WORK/calendar"
    export AREAS="$PERSONAL/Areas"
    export AREAS_ALT="$WORK/Areas"
    export INBOX=$PERSONAL/Inbox/index.md
    export INBOX_ALT=$WORK/Inbox/index.md
fi

export PROJECTS="$HOME/Projects"
export CHECKLISTS="$HOME/Personal/Checklists"

# Path
export PATH=$PATH:~/.local/bin

export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!**/.git/*' --glob '!.venv/*' --glob '!__pycache__/*'"

# Colorized man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export KEYTIMEOUT=1
export TERM=xterm-256color # for tmux

# Start x server if it's not already running
if systemctl -q is-active graphical.target && [[ ! $TMUX && ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx
fi

# Start tmux in SSH session automatically
if [[ $SSH_CONNECTION && $TMUX ]]; then
    tmux a;
elif [ $SSH_CONNECTION ]; then
    tmux;
fi

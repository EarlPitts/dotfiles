# Terminal (i3-sensible-terminal uses it)
export TERMINAL="st"

# Default editors
export EDITOR="nvim"
export VEDITOR="code"

# Some project already support this for
# opting our of telemetry
export DO_NOT_TRACK=1

export PERSONAL="$HOME/Personal"
export WORK="$HOME/Work"

# Folders
export REFERENCES="$HOME/References"
export SNIPPETS="$REFERENCES/Snippets"
export BOOKS="$REFERENCES/Books"
export CHEATSHEETS="$REFERENCES/Cheatsheets"
export PAPERS="$REFERENCES/Papers"

export PROJECTS="$HOME/Projects"

if [ "$(uname -n)" = "budl34356338a" ]; then
    export WIKI="$WORK/Wiki"
    export TODOS="$WORK/Todos"
    export CHECKLISTS="$WORK/Checklists"
    export CALENDAR="$WORK/calendar"
    #export CALENDAR_ALT="$PERSONAL/calendar"
    export AREAS="$WORK/Areas"
    #export AREAS_ALT="$PERSONAL/Areas"
    #export INBOX_ALT="$PERSONAL/Inbox"
    export INBOX="$WORK/Inbox"
else
    export WIKI="$PERSONAL/Wiki"
    export TODOS="$PERSONAL/Todos"
    export CHECKLISTS="$PERSONAL/Checklists"
    export CALENDAR="$PERSONAL/calendar"
    #export CALENDAR_ALT="$WORK/calendar"
    export AREAS="$PERSONAL/Areas"
    #export AREAS_ALT="$WORK/Areas"
    export INBOX="$PERSONAL/Inbox"
    #export INBOX_ALT="$WORK/Inbox"
fi

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

# Needed because tmux uses the deafult login shell, which is bash, and the exec zsh is only in the bashrc for now
# TODO Should be fixed somehow
[ "$TMUX" -a "$(uname -n)" = "budl34356338a" ] && exec zsh

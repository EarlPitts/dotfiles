# Terminal (i3-sensible-terminal uses it)
export TERMINAL="st"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Default editors
export EDITOR="nvim"
export VEDITOR="code"

# Some project already support this for
# opting our of telemetry
export DO_NOT_TRACK=1

export PERSONAL="$HOME/Personal"

# Folders
export REFERENCES="$HOME/References"
export SNIPPETS="$REFERENCES/Snippets"
export BOOKS="$REFERENCES/Books"
export CHEATSHEETS="$REFERENCES/Cheatsheets"
export PAPERS="$REFERENCES/Papers"

export PROJECTS="$HOME/Projects"

export WIKI="$PERSONAL/Wiki"
export TODOS="$PERSONAL/Todos"
export CHECKLISTS="$PERSONAL/Checklists"
export CALENDAR="$PERSONAL/calendar"
export AREAS="$PERSONAL/Areas"
export INBOX="$PERSONAL/Inbox"

# Path
export PATH=$PATH:~/.local/bin

export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!**/.git/*' --glob '!.venv/*' --glob '!__pycache__/*'"

# Colorized man pages
export MANPAGER="sh -c 'col -bx | bat -l man -p'"

export KEYTIMEOUT=1
export TERM=xterm-256color # for tmux

# Start x server if it's not already running
if systemctl -q is-active graphical.target && [[ ! $TMUX && ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
    exec startx "$XDG_CONFIG_HOME/X11/xinitrc"
fi

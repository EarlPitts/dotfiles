# Terminal (i3-sensible-terminal uses it)
export TERMINAL="st"

export XDG_DATA_HOME="$HOME/.local/share"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"

# Readline config
export INPUTRC="$HOME/.config/inputrc"

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

# Path
export PATH=$PATH:~/.local/bin:~/.config/emacs/bin
export GUILE_LOAD_PATH=~/.nix-profile/share/guile/site/3.0

export FZF_DEFAULT_COMMAND="rg --files --no-ignore --hidden --follow --glob '!**/.git/*' --glob '!.venv/*' --glob '!__pycache__/*'"

# Colorized man pages
export MANPAGER="bat --style snip"

export KEYTIMEOUT=1

# virsh connects to qemu:///session by default
export LIBVIRT_DEFAULT_URI=qemu:///system

if [ $(uname -s) != Darwin ]; then
    export WIKI="$PERSONAL/Wiki"
    export TODOS="$PERSONAL/Todos"
    export CHECKLISTS="$PERSONAL/Checklists"
    export AREAS="$PERSONAL/Areas"
    export INBOX="$PERSONAL/Inbox"

    # Start x server if it's not already running
    if systemctl -q is-active graphical.target && [[ ! $TMUX && ! $DISPLAY && $XDG_VTNR -eq 1 ]]; then
        exec startx "$XDG_CONFIG_HOME/X11/xinitrc"
    fi
else
    # MacOS stuff
    export WIKI="$WORK/Wiki"
    export TODOS="$WORK/Todos"
    export CHECKLISTS="$WORK/Checklists"
    export AREAS="$WORK/Areas"
    export INBOX="$WORK/Inbox"

    export PATH="$PATH:/Users/i348749/Projects/active/opstools"
    export CLOUD_SQL_IAM_USER=segmentation-sql-proxy@sap-segmentationduahubxzpsxccc.iam
    # export TERM=alacritty # for tmux

    source ~/Work/secrets

    # Brew
    eval "$(/opt/homebrew/bin/brew shellenv)"

    # Nvm
    export NVM_DIR="$HOME/.nvm"
    [ -s "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" ] && \. "$HOMEBREW_PREFIX/opt/nvm/nvm.sh" --no-use # This loads nvm

fi

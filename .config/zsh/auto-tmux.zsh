#!/usr/bin/zsh

if [[ -n "$(pgrep tmux)" && ! $TMUX ]]; then
    tmux a;
elif [[ -z "$(pgrep tmux)" ]]; then
    tmux;
fi

# Also set GPG tty
export GPG_TTY=$(tty)

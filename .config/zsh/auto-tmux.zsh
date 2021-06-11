#!/usr/bin/zsh

if [[ $SSH_CONNECTION && -n "$(pgrep tmux)" && ! $TMUX ]]; then
    tmux a;
elif [[ $SSH_CONNECTION && -z "$(pgrep tmux)" ]]; then
    tmux;
fi

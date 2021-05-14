if [[ -n $SSH_CONNECTION ]] && [[ -z "$TMUX" ]]; then
    tmux a;
fi

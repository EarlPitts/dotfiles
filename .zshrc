# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
unsetopt beep

# load antibody
source <(antibody init)
antibody bundle < ~/.config/zsh/plugins.txt

# Imports
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/environment.zsh
source ~/.config/zsh/keybindings.zsh
source ~/.config/zsh/funcs.zsh
source ~/.config/zsh/base16.zsh
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '~/.zshrc'

# Autocompletion and Propmt
autoload -Uz compinit promptinit;
compinit; promptinit

# End of lines added by compinstall

# This needs to be at the and, otherwise the
# sourcing of zshrc would stop to start tmux
source ~/.config/zsh/auto-tmux.zsh
eval "$(direnv hook zsh)"

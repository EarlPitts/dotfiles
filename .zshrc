# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
unsetopt beep

# load antibody
source <(antibody init)
antibody bundle < ~/.zsh/plugins.txt

# Imports
source ~/.zsh/aliases.zsh
source ~/.zsh/exports.zsh
source ~/.zsh/keybindings.zsh
source ~/.zsh/fzf-funcs.zsh
source ~/.zsh/funcs.zsh
#source ~/.zsh/gtd.zsh
#source ~/.zsh/widgets.zsh
source ~/.zsh/base16.zsh
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
source ~/.zsh/auto-tmux.zsh
eval "$(direnv hook zsh)"
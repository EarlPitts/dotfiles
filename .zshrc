# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt autocd
unsetopt beep

# Plugins
source ~/.local/share/zsh/zsh-async/async.plugin.zsh
source ~/.local/share/zsh/pure/pure.plugin.zsh
source ~/.local/share/zsh/zsh-autosuggestions/zsh-autosuggestions.plugin.zsh
source ~/.local/share/zsh/zsh-completions/zsh-completions.plugin.zsh
source ~/.local/share/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh
# These two are installed by the fzf package
source /usr/share/fzf/completion.zsh
source /usr/share/fzf/key-bindings.zsh

# Imports
source ~/.config/zsh/aliases.zsh
source ~/.config/zsh/keybindings.zsh
source ~/.config/zsh/funcs.zsh
source ~/.config/zsh/base16.zsh

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

alias mixer='alsamixer'                                             
alias ls='exa -l'
alias scan='sudo iw dev wlan0 scan | egrep "signal|SSID" | sed -e "s/\tsigna    l: //" -e "s/\tSSID: //" | awk '\''{ORS = (NR % 2 == 0)? "\n" : " "; print}    '\'' | sort'
alias weather='curl wttr.in/Budapest'
alias cat='bat'
alias drill='dog'
alias dig='dog'
alias df='df -h'
alias du='du -hs *'
alias grep='rg'
alias pup='pup --color'
alias dirty='watch -d grep -e Dirty: -e Writeback: /proc/meminfo'
alias curl='curlie'
alias reload='source ~/.zshrc'
alias yoga='ssh pi yoga'
alias httpserver='python -m http.server'
alias ftpserver='python -m pyftpdlib'
alias startx='startx "$XDG_CONFIG_HOME/X11/xinitrc"'
alias scheme='rlwrap -f "$XDG_DATA_HOME/mit_scheme_bindings.txt" scheme'
alias guiles='guile --listen=/tmp/.guile-socket && rm /tmp/.guile-socket'
alias diff='difft'

# rsync
alias cpr='rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1'
alias mvr='rsync --archive -hh --partial --info=stats1,progress2 --modify-window=1 --remove-source-files'

# Python
alias venv='source venv/bin/activate'
alias pdb='python -m pdb'

# Neovim
alias v='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'

alias jup='jupyter lab --ip=0.0.0.0'

alias open='xdg-open'
alias spt='spotifyd; spt'
alias gdb='gdb -q'

## Review
alias journal='nvim ~/Personal/Gratitude/$(date +%Y-%b-%d).md'
alias diary='nvim +VimwikiMakeDiaryNote +Tagbar'

## Codebase
alias code='cd ~/.snippets && nvim +Rg && cd -'

# Git
alias gc='git commit -m"Autocommit"'
alias gg='git push'
alias gcp='git commit -m"Autocommit" && git push'
alias save='git add --all && git commit -m"Autocommit." && git push'
alias ga.='git add .'
alias ggs='gitupdate .' # Commit all with file name changes as commit msg
alias gj='open `git config remote.origin.url`'
alias gm='git branch -m' # Rename current branch
alias ger='git checkout -' # Checkout last branch you were on
alias grl='git reset --hard && git clean -df' # Reset to exact state as last commit
alias grhf='git checkout HEAD --' # Git reset single file
#alias gf='git log --pretty=oneline --abbrev-commit --graph --decorate'
alias gpm="git push origin master"
alias gfk='git fetch && git reset --hard && git clean -dfx' # Reset repo to clean remote state
alias gsp='git pull --rebase --autostash' # Git stash, pull and apply stash
alias gu='git issues'
alias gdp='git reset --hard HEAD~; git push --force-with-lease' # Delete previous commit locally and remote
alias gpd="git push origin develop"
alias ggh='push -u origin HEAD'
alias gre='git rebase -i HEAD~4'
alias gS='git stash'
alias gqa='git stash apply'
alias gb='git checkout -b'
alias gr='git reset --hard'
alias grc='git rm --cached'
alias ggn='git_add_origin_and_origin_push'
alias g:='git push -u origin master'
alias ggf='git push -f'
alias g::='git_remote_add_origin_from_active_link'
alias gi='git init'
alias gl='git pull'
alias gn='git clone'
alias g.='git add .'
alias ga='git add'
alias gg='git push'
alias glp='git pull && git push'
alias grao='git remote add origin'

alias greset='git reset --soft HEAD^' # Undo last commit, but don't throw away your changes

# Git Diff
alias gd='git diff'
alias gds='git diff --staged'
alias gdn='git diff --name-only'

# Git Status
alias gs='git status --short'
alias gss='git show --word-diff=color' # See changes made

alias gist='hub gist create --copy'

alias mixer='alsamixer'                                             
alias clean='cat ~/.dotfiles/bleach.txt | xargs bleachbit -c && yay -Sc --clean --noconfirm'
alias ls='exa -l'
alias scan='sudo iw dev wlp4s0 scan | egrep "signal|SSID" | sed -e "s/\tsigna    l: //" -e "s/\tSSID: //" | awk '\''{ORS = (NR % 2 == 0)? "\n" : " "; print}    '\'' | sort'
alias weather='curl wttr.in/Budapest'
alias win='i3lock -p win -u -i ~/.dotfiles/wallpapers/winLock.jpg'
alias cat='bat --theme=base16'
alias df='df -h'
alias du='du -hs *'
alias grep='grep --color=auto'
alias pe='pet exec'
alias pup='pup --color'
alias dirty='watch -d grep -e Dirty: -e Writeback: /proc/meminfo'
alias curl='curlie'
alias sudo='doas'

# Neovim
alias v='nvim'
alias vim='nvim'
alias vimdiff='nvim -d'

alias jup='jupyter lab --ip=0.0.0.0'

alias open='xdg-open'
alias spt='spotifyd; spt'
alias gdb='gdb -q'
alias venv='source .venv/bin/activate'

# Productivity System

## Tasks
alias t='cat ~/Personal/tasks.md'
alias waiting='cat ~/Personal/waiting.md'

## Calendar
#alias cal='calcurse -D ~/Personal/Calendar -C ~/.config/calcurse'

## Projects
#alias projects='nvim +Tagbar ~/Personal/Projects/index.md'

## Notes
alias qn='nvim "+normal Go " +startinsert ~/Personal/Inbox/index.md'
alias sp='nvim $(mktemp --suffix '.md')'

## Review
alias journal='nvim ~/Personal/Gratitude/$(date +%Y-%b-%d).md'
alias diary='nvim +VimwikiMakeDiaryNote +Tagbar'

## Codebase
alias code='cd ~/.snippets && nvim +Rg && cd -'

## Areas
alias areas='nvim ~/Personal/Direction/index.md +"lcd %:p:h" +Tagbar'
alias com='nvim ~/Personal/Direction/Commitments.md +"lcd %:p:h" +Tagbar'


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
alias gf='git log --pretty=oneline --abbrev-commit --graph --decorate'
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
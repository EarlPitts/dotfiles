# Search aliases/functions
falias() {    CMD=$(
    (
    (alias)
    (functions | grep "\(\)" | cut -d ' ' -f1 | grep -v "^_" )
    ) | fzf | cut -d '=' -f1
    );

    eval $CMD
}

dislocker() {
    local partition=$(lsblk -nlo NAME,LABEL,SIZE | fzf | awk '{ print "/dev/"$1 }')
    echo -n "Password: " && read password
    sudo dislocker ${partition} -u${password} -- /run/media && 
        sudo mount -o loop /run/media/dislocker-file /mnt
}

update() {
    # Update git submodules (zsh and tmux plugins)
    git submodule update --recursive --remote
    # Update neovim plugins
    nvim --headless +PackerSync +qa 
}

tunnel() {
    echo -n "Local port: " && read local_port
    echo -n "Target port: " && read target_port
    ssh -L ${local_port}:localhost:${target_port} ${1}
}

install() {
    # TODO
    #yay -Slq | fzf -m --preview 'cat <(yay -Si {1}) <(yay -Fl {1} | awk \"{print \\$2}\")' | xargs -ro  yay -S
}

# If no arg is passed to man, it will start fzf with all
# the installed manpages
man() {
    if [ $# -gt 0 ]; then
        command man $@
    else
        command man -k . | fzf | cut -d' ' -f1,2 | tr -d '()' | awk '{s=$1;$1=$NF;$NF=s}1' | xargs man
    fi
}

# Codi
# Usage: codi [filetype] [filename]
codi() {
    local syntax="${1:-python}"
    #shift
    vim -c \
    "set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}

scm() {
    vim -c \
    "set bt=nofile ls=0 noru nonu nornu splitright |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    let g:conjure#log#hud#enabled = v:false" \
    $(mktemp --suffix=.scm)
}

# Open wiki, or create it if it doesn't exist yet
wiki() {
    if [ -d "wiki" ]; then
        nvim wiki/index.md
    else
        echo -n "No wiki folder, create it? [y/n]"
        read
        [ "$REPLY" = "y" ] && mkdir wiki && nvim wiki/index.md
    fi
}

# Show $PATH
path() {
    echo -e ${PATH//:/\\n}
}

# filenum <dir> - Give number of files found inside given directory.
filenum() {
    find "$1" -type f | wc -l
}

# Get cheat sheet of command from cheat.sh. h <cmd>
h() {
    curl -s cheat.sh/${@:-cheat}
}

# cfile <file> - Copy content of file to clipboard
cfile() {
    cat $1 | xclip
}

# down <url> - Download <url> and save to current dir.
down() {
    curl -O "$1"
}

# Lists my remote repos and clones the selected one
clone() {
    local repo=$(ssh git@ben ls | fzf)
    [ -n "$repo" ] && git clone git@ben:"$repo"
}


# Edit dotfiles
d() {
    cd ~
    local dotfile=$(git ls-files | fzf-tmux -r 30% --reverse)
    [ -n "$dotfile" ] && nvim $dotfile
    cd -
}

kp() {
    local pid=$(ps -ef | sed 1d | eval "fzf ${FZF_DEFAULT_OPTS} -m --header='[kill:process]'" | awk '{print $2}')

    if [ -n "$pid" ]
    then
        echo $pid | xargs kill -${1:-9}
        kp
    fi
}

rp() {
    local package=$(yay -Qet | fzf)

    if [ -n "$package" ]; then
        yay -Rns $(echo $package | cut -f1 -d" ")
    fi
}

gitgrep() {
    git grep "$1" $(git rev-list --all)
}

fa() {
  local dir
  dir=$(find ${1:-.} -path '*/\.*' -prune \
                  -o -type d -print 2> /dev/null | fzf +m) &&
  cd "$dir"
}

# fkil() {
#   local pid
#   pid=$(ps -ef | sed 1d | fzf -m | awk '{print $2}')

#   if [ "x$pid" != "x" ]
#   then
#     echo $pid | xargs kill -${1:-9}
#   fi
# }

gf() {
  git log --graph --color=always \
      --format="%C(auto)%h%d %s %C(black)%C(bold)%cr" "$@" |
  fzf --ansi --no-sort --reverse --tiebreak=index --bind=ctrl-s:toggle-sort \
      --bind "ctrl-m:execute:
                (grep -o '[a-f0-9]\{7\}' | head -1 |
                xargs -I % sh -c 'git show --color=always % | less -R') << 'FZF-EOF'
                {}
FZF-EOF"
}

# Creates a sandbox environment for fun
sandbox() {
local name
local environment

echo -n "[p]y/[s]hell/p[e]ntest: " && read environment
echo -n "name: " && read name

case "$environment" in
    p)
        cd ~/Desktop || exit
        mkdir $name
        cd $name 
        python -m venv venv
        echo "source venv/bin/activate" > .envrc
        direnv allow ;;
    s) 
        cd ~/Desktop || exit
        mkdir $name
        cd $name 
        docker run --rm --net=host -itv $(pwd):/home archlinux/archlinux bash ;;
    e) 
        cd ~/Desktop || exit
        mkdir $name
        cd $name 
        docker run --rm --net=host -itv $(pwd):/home kalilinux/kali-rolling bash ;;
esac
}

# # Delete branches that have been squashed and merged into master (https://github.com/not-an-aardvark/git-delete-squashed)
# # TODO: git-trim may replace this
# gdelsquashed() {
#   git checkout -q master && git for-each-ref refs/heads/ "--format=%(refname:short)" | while read branch; do mergeBase=$(git merge-base master $branch) && [[ $(git cherry master $(git commit-tree $(git rev-parse $branch^{tree}) -p $mergeBase -m _)) == "-"* ]] && git branch -D $branch; done
# }


# findEmptyDirsAndFiles(){
#   find . -type f -exec bash -c 'if [ `cat "{}" |wc -w` -eq 0 ]; then echo "file - {}";fi' \; -or -empty -exec bash -c "echo dir - {}" \;
# }

# convertAllMDFilesToTabs(){
#  find . -name '*.md' ! -type d -exec bash -c 'expand -t 4 "$0" > /tmp/e && mv /tmp/e "$0"' {} \;
# }


# # Lowercase every file in current dir
# lowercaseCurrentDir(){
#   for i in *; do mv $i ${(L)i}; done
# }


# # Fetch pull request
# fpr() {
#     if ! git rev-parse --git-dir > /dev/null 2>&1; then
#         echo "error: fpr must be executed from within a git repository"
#         return 1
#     fi
#     (
#         cdgr
#         if [ "$#" -eq 2 ]; then
#             local repo="${PWD##*/}"
#             local user="${1}"
#             local branch="${2}"
#         elif [ "$#" -eq 3 ]; then
#             local repo="${1}"
#             local user="${2}"
#             local branch="${3}"
#         else
#             echo "Usage: fpr [repo] username branch"
#             return 1
#         fi

#         git fetch "git@github.com:${user}/${repo}" "${branch}:${user}/${branch}"
#     )
# }

# # iz <png-file> - Create geometric primitive of png-file.
# iz () {
#     primitive -i in.png -o output.png -n "$1"
# }

# # rft <file.py> - Rerun <file.py> on any Python file changes inside current dir.
# rft() {
#   reflex -g '*.py' python3 "$@"
# }

# # compress <file/dir> - Compress <file/dir>.
# compress()
#   {
#     dirPriorToExe=`pwd`
#     dirName=`dirname $1`
#     baseName=`basename $1`

#     if [ -f $1 ] ; then
#       echo "It was a file change directory to $dirName"
#       cd $dirName
#       case $2 in
#         tar.bz2)
#           tar cjf $baseName.tar.bz2 $baseName
#           ;;
#         tar.gz)
#               tar czf $baseName.tar.gz $baseName
#               ;;
#         gz)
#               gzip $baseName
#               ;;
#         tar)
#               tar -cvvf $baseName.tar $baseName
#               ;;
#         zip)
#               zip -r $baseName.zip $baseName
#               ;;
#         *)
#               echo "Method not passed compressing using tar.bz2"
#               tar cjf $baseName.tar.bz2 $baseName
#               ;;
#           esac
#           echo "Back to Directory $dirPriorToExe"
#           cd $dirPriorToExe
#         else
#           if [ -d $1 ] ; then
#             echo "It was a Directory change directory to $dirName"
#             cd $dirName
#             case $2 in
#               tar.bz2)
#                 tar cjf $baseName.tar.bz2 $baseName
#                 ;;
#           tar.gz)
#                 tar czf $baseName.tar.gz $baseName
#                 ;;
#           gz)
#                 gzip -r $baseName
#                 ;;
#           tar)
#                 tar -cvvf $baseName.tar $baseName
#                 ;;
#           zip)
#                 zip -r $baseName.zip $baseName
#                 ;;
#           *)
#                 echo "Method not passed compressing using tar.bz2"
#                 tar cjf $baseName.tar.bz2 $baseName
#                 ;;
#             esac
#             echo "Back to Directory $dirPriorToExe"
#             cd $dirPriorToExe
#           else
#             echo "'$1' is not a valid file/folder"
#           fi
#         fi
#         echo "Done"
#         echo "###########################################"
#       }

# # List commit hashes
# commits() {
#   git log $1 --oneline --reverse | cut -d' ' -f 1 | tr '/n' ' '
# }

# # ram <process-name> - Find how much RAM a process is taking.
# ram() {
#   local sum
#   local items
#   local app="$1"
#   if [ -z "$app" ]; then
#     echo "First argument - pattern to grep from processes"
#   else
#     sum=0
#     for i in `ps aux | grep -i "$app" | grep -v "grep" | awk '{print $6}'`; do
#       sum=$(($i + $sum))
#     done
#     sum=$(echo "scale=2; $sum / 1024.0" | bc)
#     if [[ $sum != "0" ]]; then
#       echo "${fg[blue]}${app}${reset_color} uses ${fg[green]}${sum}${reset_color} MBs of RAM."
#     else
#       echo "There are no processes with pattern '${fg[blue]}${app}${reset_color}' are running."
#     fi
#   fi
# }

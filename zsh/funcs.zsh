# Start watson with selectable project
start() {
    watson start $(watson projects | fzf)
}

# Search aliases/functions
falias() {    CMD=$(
    (
    (alias)
    (functions | grep "()" | cut -d ' ' -f1 | grep -v "^_" )
    ) | fzf | cut -d '=' -f1
    );

    eval $CMD
}

check() {
    local folder=~/Personal/Checklists 
    local checklist=$(command ls $folder | fzf)
    [ -n "$checklist" ] && nvim $folder/$checklist
}

# Send to the server for archiving
archive() {
    if [ -d "$1" ]; then 
        tar cf "$1".tar "$1"
        rsync -avz "$1".tar ben:Archive
    else
        rsync -avz "$1" ben:Archive
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

wiki() {
    if [[ -e wiki/index.md ]]; then
        nvim +Tagbar wiki/index.md
    elif [[ $1 == "i" ]]; then
        nvim +VimwikiIndex +"lcd %:p:h" +Tagbar
    else
        note=$(fd -e md . ~/Personal/Notes | fzf)
        [[ -n "$note" ]] && nvim +"lcd %:p:h" +Tagbar $note
    fi
}

sap() {
    if [[ $1 == "i" ]]; then
        nvim ~/Work/Notes/index.md +"lcd %:p:h" +Tagbar
    else
        note=$(fd -e md . ~/Work/Notes | fzf)
        [[ -n "$note" ]] && nvim +"lcd %:p:h" +Tagbar $note
    fi
}

meeting() {
    if [[ $# == 0 ]]; then
        cd ~/notes
        nvim index.md +Tagbar
    else
        nvim ~/notes/$1.md +Tagbar
    fi
}

# Show $PATH
path() {
    echo -e ${PATH//:/\\n}
}

p() {
    project=$(command ls ~/Projects | fzf)
    if [ -n "$project" ]; then
        cd ~/Projects/$project
        tmux new -s $project
    fi
}

# md <dir-name> - Create directory and cd into it.
md() {
  [[ -n "$1" ]] && mkdir -p "$1" && builtin cd "$1"
}

# filenum <dir> - Give number of files found inside given directory.
filenum() {
    find "$1" -type f | wc -l
}

# Get cheat sheet of command from cheat.sh. h <cmd>
h() {
    curl cheat.sh/${@:-cheat}
}

# cfile <file> - Copy content of file to clipboard
cfile() {
    cat $1 | xclip
}

# down <url> - Download <url> and save to current dir.
down() {
    curl -O "$1"
}

# Taskwarrior add task
tn() {
    echo -n "Description: "
    read descr
    echo -n "Due date: "
    read due
    echo -n "Tag: ([h]ome/[w]ork/[b]locked) "
    read tag
    echo -n "Energy required? (1/2/3) "
    read energy
    task add $descr $([ "$tag" = "h" ] && echo '+home') $([ "$tag" = "w" ] && echo '+work') $([ "$tag" = "b" ] && echo '+blocked') due:$due energy:$energy
}

# Edit dotfiles
d() {
    local dir=~/.dotfiles
    local dotfile=$(find $dir -type f -not -path '*/\.git/*' -not -path '*/\.dotbot/*' | fzf)
    [ -n "$dotfile" ] && nvim $dotfile
}

# Edit scripts
s() {
    local dir=~/.scripts
    local script=$(find $dir -type f -not -path '*/\.git/*' | fzf)
    [ -n "$script" ] && nvim $script
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


# # server - Create server of current dir on port 8000 and open it in browser.
# server() {
#     sleep 1 && xdg-open http://localhost:8000 &
#     python -m http.server
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

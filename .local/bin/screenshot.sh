#!/usr/usr/bin/sh

FILENAME="/home/obabo/Personal/Inbox/$(date +%F_%H%M%S).png"
NOTE_FILENAME="/home/obabo/Personal/Notes/pics/$(date +%F_%H%M%S).png"

if [ $# = 0 ]; then
    scrot $FILENAME -e 'xclip -selection c -t image/png < $f'
elif [ $1 = "select" ]; then
    scrot -s $FILENAME -e 'xclip -selection c -t image/png < $f && feh $f'
elif [ $1 = "note" ]; then
    scrot -s $NOTE_FILENAME -e "echo '![]('$NOTE_FILENAME')' | xclip"
fi

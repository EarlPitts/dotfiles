#!/usr/bin/zsh
LENGTH=24
FILE=/tmp/pomodoro

if [[ -e $FILE ]]; then
    notify-send "$(cat $FILE) minutes passed"
    exit 0
fi

notify-send "Pomodoro started"
touch $FILE
for minute in {0..$LENGTH}; do
    echo $minute > $FILE
    sleep 60
done
rm $FILE
notify-send "Pomodoro done"

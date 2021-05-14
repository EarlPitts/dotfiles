#!/usr/bin/zsh

pos_x=$(( $(xrandr | grep \* | head -n 1| cut -d' ' -f4  | cut -d'x' -f1) / 2 ))
pos_y=$(( $(xrandr | grep \* | head -n 1| cut -d' ' -f4  | cut -d'x' -f2) / 2.5 ))


i3lock -u -k -e \
--timestr="%H:%M" --timecolor=09050390 --timesize=45 \
--datestr="%B %d, %A" --datecolor=09050390 \
--greetertext="Hi, I'm a computer." --greetercolor=09050370 --greeterpos="${pos_x}:${pos_y}" --greetersize=40 \
 -i ~/.dotfiles/wallpapers/lockScreen.jpg \
 --pass-media-keys


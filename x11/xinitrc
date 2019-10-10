#!/bin/sh

#userresources=$HOME/.Xresources
#usermodmap=$HOME/.Xmodmap
#sysresources=/etc/X11/xinit/.Xresources
#sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

#if [ -f $sysresources ]; then
#    xrdb -merge $sysresources

#fi

#if [ -f $sysmodmap ]; then
#    xmodmap $sysmodmap
#fi

#if [ -f "$userresources" ]; then
#    xrdb -merge "$userresources"

#fi

#if [ -f "$usermodmap" ]; then
#    xmodmap "$usermodmap"
#fi

# start some nice programs
#[[ -f ~/.Xmodmap ]] && xmodmap ~/.Xmodmap

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

rescuetime &
~/.Scripts/rclone_watch_local.sh 1> ~/logs &
feh --no-fehbg --bg-fill '/home/obabo/.dotfiles/background.jpg'
light -S 100
xrdb -merge ~/.Xresources
#~/.config/monitor.sh &
#~/.Scripts/headphones.sh &
#twm &
#Start Window Manager
exec i3

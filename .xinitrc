#!/bin/sh

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#calcurse -D ~/Personal/Calendar -C ~/.config/ --daemon 
# Set Background
feh --no-fehbg --bg-fill ~/.local/share/wallpapers/background.jpg
xrdb -merge ~/.Xresources

# Start Window Manager
exec i3 

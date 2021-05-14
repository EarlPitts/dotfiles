#!/usr/bin/sh

if [ $(setxkbmap -query | grep layout | cut -d: -f2) = "us" ]
then
        setxkbmap hu
        notify-send " Layout set to Hungarian"
else
        setxkbmap us
        notify-send " Layout set to English"
fi


#!/usr/bin/sh

intern="eDP1"
extern=$(xrandr | grep -E "^HDMI2 connected|^DP1 connected " | tail -n 1 | cut -f1 -d" ")
#extern=$(xrandr | grep "DP1 connected " | tail -n 1 | cut -f1 -d" ")

if [[ ! -e /tmp/monitorstate ]]; then
    echo "doubled" > /tmp/monitorstate
    xrandr --output "$extern" --auto --output "$intern" --auto
    pactl set-card-profile 0 output:hdmi-stereo-extra1+input:analog-stereo
    notify-send "Mirroring Screen"
elif [[ $(cat /tmp/monitorstate) = "doubled" ]]; then
    echo "extended" > /tmp/monitorstate
    xrandr --output "$intern" --auto --output "$extern" --right-of $intern
    pactl set-card-profile 0 output:hdmi-stereo-extra1+input:analog-stereo
    notify-send "Extending Screen"
elif [[ $(cat /tmp/monitorstate) = "extended" ]]; then
    echo "only" > /tmp/monitorstate
    xrandr --output "$intern" --off --output "$extern" --auto
    pactl set-card-profile 0 output:hdmi-stereo-extra1+input:analog-stereo
    notify-send "Screen 2"
elif [[ $(cat /tmp/monitorstate) = "only" ]]; then
    rm /tmp/monitorstate
    xrandr --output "$intern" --auto --output "$extern" --off
    pactl set-card-profile 0 output:analog-stereo+input:analog-stereo
    notify-send "Screen 1"
fi
#!/bin/bash

usb=$( lsblk -nlo NAME,LABEL,SIZE | awk  'NF > 2{ print $0 }' | rofi -dmenu -i | cut -d" " -f1 )

if [[ -a /dev/"${usb}" ]]; then
    if [ $(df | grep -c "${usb}") != 1 ]; then
        udisksctl mount -b /dev/"${usb}" && notify-send "Mounted ${usb}"
    else
        udisksctl unmount -b /dev/"${usb}" && notify-send "Unmunted ${usb}"
    fi
fi
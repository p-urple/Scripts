#!/bin/bash

file="Screenshot $(date +"%Y-%m-%d %H:%M:%S").png"
scrot "$file" -e 'mv "$f" ~/Dropbox/Screenshots/'
xclip -sel clip -t image/png ~/Dropbox/Screenshots/"$file"
notify-send "SNAP! Yep. This is going in my cringe compilation."

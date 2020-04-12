#!/bin/sh
set -eu
method=slop

shot="Screenshot $(date +"%Y-%m-%d %H:%M:%S").png"
save=~/Dropbox/Screenshots/$shot

case $method in
    scrot)
        scrot
        ;;
    slop)
    file=$(mktemp -d /tmp/screenshot-XXXXXX)/screenshot.png
    dimens=`slop --format '%x,%y,%w,%h'`
    scrot --overwrite --autoselect $dimens "$file"
    xclip -sel clip -t image/png $file
    ;;
    maim)
    file=$(mktemp -u -t /tmp/screenshot-XXXXXX.png)
        maim -s -u -f png > $file
        xclip -sel clip -t image/png $file
        ;;
esac

xclip -out -sel clip > "$save"

notify-send "SNAP! Yep. This is going in my cringe compilation."

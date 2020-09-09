#!/bin/sh -eu
PIDFILE="/tmp/$USER-rd.pid"
PATHFILE="/tmp/$USER-rd"

outdir="$HOME/Videos/rd"
outext=".webm"

clean_files () {
	rm -f "$PIDFILE" "$PATHFILE"
}

if [ -f $PIDFILE ]; then
	trap clean_files EXIT

	kill -s INT `cat "$PIDFILE"`
	message="Video recorded at `cat "$PATHFILE"`"
	notify-send "$message"
	echo "$message"

	rm -f "$PIDFILE" "$PATHFILE"
else
	frameinfo=`slop --format="%wx%h +%x,%y"`
	size=`echo "$frameinfo" | cut -d' ' -f 1`
	offset=`echo "$frameinfo" | cut -d' ' -f 2`

	mkdir -p "$outdir"

	path=`date +"$outdir/rd_%Y-%m-%d_%H-%M-%S$outext"`
	ffmpeg -video_size "$size" \
		-framerate 25 \
		-f x11grab \
		-i "$DISPLAY$offset" \
		-c:v libvpx \
		-crf 23 \
		"$path" &
	echo "$!" > "$PIDFILE"
	echo "$path" > "$PATHFILE"
fi

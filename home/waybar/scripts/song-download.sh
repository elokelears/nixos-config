#!/usr/bin/env bash
if (yt-dlp -x --audio-format mp3 -o '~/Music/%(title)s.%(ext)s' $(wl-paste)); then
    notify-send "Download Complete" "Song saved in ~/Music" -t 4000
else
    notify-send "Download Error" "Error while downloading a song" -u critical -t 4000
fi
#!/usr/bin/env bash
if (yt-dlp -o '~/Videos/%(title)s.%(ext)s' $(wl-paste)); then
    notify-send "Download Complete" "Video saved in ~/Videos" -t 4000
else
    notify-send "Download Error" "Error while downloading a video" -u critical -t 4000
fi
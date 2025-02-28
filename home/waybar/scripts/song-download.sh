#!/usr/bin/env bash
if (yt-dlp -x --audio-format mp3 -o '~/Music/%(title)s.%(ext)s' $(wl-paste)); then
  hyprctl notify 5 4000 "rgb(0000ff)" " Song saved in ~/Music"
else
  hyprctl notify 3 4000 "rgb(ff0000)" " Error while downloading a song"
fi
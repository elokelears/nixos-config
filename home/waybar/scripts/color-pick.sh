#!/usr/bin/env bash
colr=$(hyprpicker -a)
colr2="${colr:1}"
if [ "$colr" ]; then
    notify-send "rgb($colr2)" "$colr copied to clipboard" -t 4000
fi
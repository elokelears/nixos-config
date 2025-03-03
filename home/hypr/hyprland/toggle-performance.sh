#!/usr/bin/env bash

current = $(powerprofilesctl get)

case "$current" in 
  "power-saver")
     powerprofilesctl set balanced
     notify-send "Power-Setting" "switched to balanced mode" -i battery -t 2000 
     ;;
  "balanced")
     powerprofilesctl set performance
     notify-send "Power-Setting" "switched to performance mode" -i battery -t 2000
     ;;
  "performance")
     powerprofilesctl set power-saver
     notify-send "Power-Setting" "switched to power-saver mode" -i battery -t 2000
     ;;
esac
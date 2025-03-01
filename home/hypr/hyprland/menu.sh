#!/usr/bin/env bash


# 使用 rofi/wofi 显示与 nixos-menu.xml 相同的选项
CHOICE=$(echo -e " videoDL\ nmusicDL\n colorPicker\n screenShot\n wallpaperChange\n󰩈 exit" | rofi -show -dmenu)

case "$CHOICE" in
    " videoDL")
        ../../waybar/scripts/video-download.sh
        ;;
    " musicDL")
        ../../waybar/scripts/song-download.sh
        ;;
    " colorPicker")
        ../../waybar/scripts/color-pick.sh
        ;;
    " screenShot")
        ../../waybar/scripts/screenshot.sh
        ;;
    " wallpaperChange")
        ../../waybar/scripts/select-wallpaper.sh
        ;;
    "󰩈 exit")
        wlogout -m 260px 70px
        ;;
esac
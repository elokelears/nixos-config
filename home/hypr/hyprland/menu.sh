#!/usr/bin/env bash
# ~/scripts/nixos-menu.sh

# 使用 rofi/wofi 显示与 nixos-menu.xml 相同的选项
CHOICE=$(echo -e "视频下载\n音乐下载\n颜色拾取器\n截图\n更换壁纸\n退出" | rofi --dmenu)

case "$CHOICE" in
    "视频下载")
        ~/scripts/video-download.sh
        ;;
    "音乐下载")
        ~/scripts/song-download.sh
        ;;
    "颜色拾取器")
        ~/scripts/color-pick.sh
        ;;
    "截图")
        ~/scripts/screenshot.sh
        ;;
    "更换壁纸")
        ~/scripts/select-wallpaper.sh
        ;;
    "退出")
        wlogout -m 260px 70px
        ;;
esac
#!/usr/bin/env bash

# 壁纸源文件夹路径
PHOTOS_DIR="$HOME/Pictures"

# 脚本路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 存放的文件夹路径
NIXOS_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"

# 壁纸保存路径
WALLPAPER_PATH="$NIXOS_DIR/wallpaper.png"

# 临时文件路径
TEMP_FILE="/tmp/selected_wallpaper_$$"

# 创建临时目录
trap 'rm -f "$TEMP_FILE"' EXIT

# 确保图片目录存在
if [ ! -d "$PHOTOS_DIR" ]; then
    mkdir -p "$PHOTOS_DIR"
fi

# 使用文件选择器打开图片目录
if command -v xdg-open &> /dev/null; then
    # 对于大多数Linux桌面环境
    xdg-open "$PHOTOS_DIR" &
elif command -v open &> /dev/null; then
    # 对于macOS
    open "$PHOTOS_DIR" &
elif command -v explorer.exe &> /dev/null; then
    # 对于WSL
    explorer.exe "$(wslpath -w "$PHOTOS_DIR")" &
elif command -v dolphin &> /dev/null; then
    # KDE Plasma
    dolphin "$PHOTOS_DIR" &
elif command -v nautilus &> /dev/null; then
    # GNOME
    nautilus "$PHOTOS_DIR" &
elif command -v thunar &> /dev/null; then
    # XFCE
    thunar "$PHOTOS_DIR" &
elif command -v pcmanfm &> /dev/null; then
    # LXDE/LXQT
    pcmanfm "$PHOTOS_DIR" &
elif command -v nemo &> /dev/null; then
    # Cinnamon
    nemo "$PHOTOS_DIR" &
else
    echo "无法找到合适的文件管理器"
    exit 1
fi

# 使用文件选择对话框选择壁纸
if command -v zenity &> /dev/null; then
    selected_file=$(zenity --file-selection --title="选择壁纸" --filename="$PHOTOS_DIR/" --file-filter="图片文件 | *.jpg *.jpeg *.png *.gif *.bmp *.webp")
elif command -v kdialog &> /dev/null; then
    selected_file=$(kdialog --title "选择壁纸" --getopenfilename "$PHOTOS_DIR" "*.jpg *.jpeg *.png *.gif *.bmp *.webp")
elif command -v yad &> /dev/null; then
    selected_file=$(yad --file --title="选择壁纸" --filename="$PHOTOS_DIR/" --file-filter="图片文件 | *.jpg *.jpeg *.png *.gif *.bmp *.webp")
elif command -v qarma &> /dev/null; then
    selected_file=$(qarma --file-selection --title="选择壁纸" --filename="$PHOTOS_DIR/" --file-filter="图片文件 | *.jpg *.jpeg *.png *.gif *.bmp *.webp")
else
    echo "无法找到合适的文件选择对话框程序"
    exit 1
fi

# 检查是否选择了文件
if [ -n "$selected_file" ] && [ -f "$selected_file" ]; then
    # 复制图片到壁纸位置
    cp "$selected_file" "$WALLPAPER_PATH"
    
    # 通知用户
    if command -v notify-send &> /dev/null; then
        #notify-send "壁纸已设置" "图片保存在: $WALLPAPER_PATH" -i "$WALLPAPER_PATH"
    fi
    
    # 可选：如果你使用swww作为壁纸管理器，可以直接设置壁纸
    # if command -v swww &> /dev/null; then
    #    swww img "$WALLPAPER_PATH" --transition-type grow --transition-pos "$(hyprctl cursorpos -j | jq -r '.x, .y')"
    # fi
    
    echo "壁纸已更新至: $WALLPAPER_PATH"
    exit 0
else
    echo "未选择文件或文件不存在"
    exit 1
fi
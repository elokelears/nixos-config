#!/usr/bin/env bash

# 定义路径
PHOTOS_DIR="$HOME/Pictures"

NIXOS_DIR="$HOME/nixos-config"

WALLPAPER_PATH="$NIXOS_DIR/wallpaper.png"

# 确保图片目录存在
if [ ! -d "$PHOTOS_DIR" ]; then
    mkdir -p "$PHOTOS_DIR"
fi

# 选择合适的文件选择器（支持预览）
select_file() {
    if command -v yad &> /dev/null; then
        # YAD支持预览图片
        yad --file --title="选择壁纸" --filename="$PHOTOS_DIR/" \
            --width=800 --height=600 --preview \
            --file-filter="图片文件 | *.jpg *.jpeg *.png *.gif *.bmp *.webp" \
            --preview-command="magick convert \$FILENAME -resize 800x800\! png:- | yad --image"
    elif command -v zenity &> /dev/null; then
        # 使用Zenity作为备选
        zenity --file-selection --title="选择壁纸" --filename="$PHOTOS_DIR/" \
               --file-filter="图片文件 | *.jpg *.jpeg *.png *.gif *.bmp *.webp"
    elif command -v kdialog &> /dev/null; then
        # KDE的文件选择器
        kdialog --title "选择壁纸" --getopenfilename "$PHOTOS_DIR" "图片文件 (*.jpg *.jpeg *.png *.gif *.bmp *.webp)"
    else
        # 如果没有合适的图形界面选择器，使用图形文件管理器
        show_file_manager
        
        # 然后使用命令行选择器作为备选
        read -p "请输入图片路径: " manual_path
        echo "$manual_path"
        return
    fi
}

# 显示文件管理器
show_file_manager() {
    for fm in nautilus dolphin thunar pcmanfm nemo caja xdg-open; do
        if command -v $fm &> /dev/null; then
            $fm "$PHOTOS_DIR" &
            return 0
        fi
    done
    echo "无法找到合适的文件管理器"
    return 1
}

# 显示通知
show_notification() {
    local title="$1"
    local message="$2"
    local icon="$3"
    
    if command -v notify-send &> /dev/null; then
        notify-send "$title" "$message" -i "$icon"
    else
        echo "$title: $message"
    fi
}

# 主函数
main() {
    # 选择文件
    selected_file=$(select_file)
    
    # 检查是否选择了文件
    if [ -n "$selected_file" ] && [ -f "$selected_file" ]; then
        # 复制图片到壁纸位置
        cp "$selected_file" "$WALLPAPER_PATH"
        
        # 通知用户
        show_notification "壁纸已设置" "壁纸已保存到: $WALLPAPER_PATH\n您可能需要运行nixos-rebuild来使更改生效" "$WALLPAPER_PATH"
        
        echo "壁纸已更新至: $WALLPAPER_PATH"
        return 0
    else
        show_notification "操作取消" "未选择文件或文件不存在" "dialog-error"
        echo "未选择文件或文件不存在"
        return 1
    fi
}

# 执行主函数
main
exit $?
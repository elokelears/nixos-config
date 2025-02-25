#!/usr/bin/env bash
# 壁纸源文件夹路径
PHOTOS_DIR="$HOME/Pictures"
# 脚本路径
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
# 存放的文件夹路径
NIXOS_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
# 壁纸保存路径
WALLPAPER_PATH="$NIXOS_DIR/wallpaper.png"
# 临时目录
TEMP_DIR="/tmp/wallpaper-selector-$$"
# 缩略图大小
THUMB_SIZE=150

# 创建临时目录
mkdir -p "$TEMP_DIR/thumbs"
trap 'rm -rf "$TEMP_DIR"' EXIT



# 查找所有图片文件
find "$PHOTOS_DIR" -type f \( -name "*.jpg" -o -name "*.jpeg" -o -name "*.png" -o -name "*.gif" -o -name "*.bmp" -o -name "*.webp" \) > "$TEMP_DIR/photo_list.txt"

if [ ! -s "$TEMP_DIR/photo_list.txt" ]; then
  # notify-send "错误" "没有找到图片文件"
  exit 1
fi

# 创建rofi配置文件
cat > "$TEMP_DIR/style.rasi" << EOF
* {
    background-color: #2E3440;
    text-color: #ECEFF4;
}
window {
    width: 80%;
    height: 80%;
}
element {
    orientation: vertical;
    padding: 2px;
    spacing: 2px;
}
element-icon {
    size: ${THUMB_SIZE}px;
}
element-text {
    horizontal-align: 0.5;
    vertical-align: 0.5;
}
listview {
    columns: 4;
    flow: horizontal;
    fixed-columns: true;
}
EOF

# 处理图片并创建缩略图
while IFS= read -r img_path; do
  # 获取文件名
  filename=$(basename "$img_path")
  # 创建缩略图
  thumb_path="$TEMP_DIR/thumbs/$filename.png"
  convert "$img_path" -resize "${THUMB_SIZE}x${THUMB_SIZE}^" -gravity center -extent ${THUMB_SIZE}x${THUMB_SIZE} "$thumb_path"
  
  # 添加到rofi显示列表
  echo "$filename|$img_path|$thumb_path" >> "$TEMP_DIR/rofi_entries.txt"
done < "$TEMP_DIR/photo_list.txt"

# 使用rofi选择图片
selected=$(cat "$TEMP_DIR/rofi_entries.txt" | rofi -dmenu -theme "$TEMP_DIR/style.rasi" \
  -i -p "选择壁纸" \
  -format 'i' \
  -display-column-separator "|" \
  -display-columns 1 \
  -show-icons \
  -kb-custom-1 "Alt+r" \
  -kb-custom-2 "Alt+p" \
  -mesg "选择一张图片作为壁纸 | Alt+r: 随机选择 | Alt+p: 预览")

exit_code=$?

# 处理rofi返回值
if [ $exit_code -eq 10 ]; then
  # Alt+r: 随机选择
  total=$(wc -l < "$TEMP_DIR/rofi_entries.txt")
  random_num=$((RANDOM % total))
  selected=$random_num
fi

if [ $exit_code -eq 11 ]; then
  # Alt+p: 预览模式
  # 这里可以实现预览功能，但对于waybar模块可能不太必要
  exit 0
fi

# 检查是否选择了图片
if [ -n "$selected" ]; then
  # 获取图片路径
  selected_path=$(sed -n "$((selected+1))p" "$TEMP_DIR/rofi_entries.txt" | cut -d'|' -f2)
  
  # 复制图片到壁纸位置
  cp "$selected_path" "$WALLPAPER_PATH"
  
  # 通知用户
  if command -v notify-send &> /dev/null; then
    # notify-send "壁纸已设置" "图片保存在: $WALLPAPER_PATH" -i "$WALLPAPER_PATH"
  fi
  
  # 可选：如果你使用swww作为壁纸管理器，可以直接设置壁纸
  # if command -v swww &> /dev/null; then
  #   swww img "$WALLPAPER_PATH" --transition-type grow --transition-pos "$(hyprctl cursorpos -j | jq -r '.x, .y')"
  # fi
  
  exit 0
else
  exit 1
fi

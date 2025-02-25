#!/usr/bin/env bash

# 音量调整的步进值（百分比）
STEP=2

# 根据参数执行不同的操作
case "$1" in
    "up")
        # 增加音量
        pactl set-sink-volume @DEFAULT_SINK@ +${STEP}%
        ;;
    "down")
        # 减少音量
        pactl set-sink-volume @DEFAULT_SINK@ -${STEP}%
        ;;
    "mute")
        # 切换静音状态
        pactl set-sink-mute @DEFAULT_SINK@ toggle
        ;;
    "open")
        # 打开pavucontrol
        pavucontrol &
        ;;
    *)
        echo "用法: $0 {up|down|mute|open}"
        exit 1
        ;;
esac

# 获取当前音量以便在通知中显示
VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | grep -Po '[0-9]+(?=%)' | head -1)
MUTED=$(pactl get-sink-mute @DEFAULT_SINK@ | grep -q "yes" && echo "已静音" || echo "音量: ${VOLUME}%")

# 使用通知显示当前音量状态（可选）
#if command -v notify-send > /dev/null; then
   # notify-send -t 800 -h string:x-canonical-private-synchronous:volume "音量控制" "$MUTED" -h int:value:"$VOLUME"
#fi

exit 0
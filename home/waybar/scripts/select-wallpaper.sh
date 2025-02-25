#!/usr/bin/env bash

# 壁纸源文件夹路径
PHOTOS_DIR="$HOME/Pictures"

CRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 获取nixos文件夹路径
NIXOS_DIR="$(cd "$SCRIPT_DIR/../../.." && pwd)"

echo "NIXOS_DIR: $NIXOS_DIR"
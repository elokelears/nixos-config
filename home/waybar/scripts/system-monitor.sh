#!/usr/bin/env bash

# Get system metrics
CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
MEM=$(free -m | grep Mem | awk '{printf "%.1f", $3/$2*100}')
DISK=$(df -h / | awk '/\// {print $5}' | tr -d '%')

# Round CPU to one decimal place
CPU=$(printf "%.1f" $CPU)

# Create JSON with HTML spans that will be hidden/shown via CSS
echo "{\"text\": \"CPU: ${CPU}%\", \"tooltip\": \"CPU: ${CPU}% | RAM: ${MEM}% | Disk: ${DISK}%\"}"
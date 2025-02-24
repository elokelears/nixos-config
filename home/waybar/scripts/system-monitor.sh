#!/bin/bash

CPU=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1}')
MEM=$(free -m | grep Mem | awk '{print $3/$2*100}')
DISK=$(df -h / | awk '/\// {print $5}' | tr -d '%')
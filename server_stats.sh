#!/bin/bash

LOG_DIR="/var/log/sys_stats_logs"

# Check if Log folder exists and create if !=
if [ ! -d "$LOG_DIR" ]; then
    mkdir -p "$LOG_DIR"
fi

LOG_FILE="$LOG_DIR"/system_stats_$(date +%Y%m%d%H%m%S).log"

exec > >(tee -a $LOG_FILE) 2>&1
echo "System Statistics"
echo "=================="

# Total CPU usage
echo "CPU Usage:"
top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/" | awk '{print 100 - $1"%"}'

# Total memory usage
echo -e "\nMemory Usage:"
free -m | awk 'NR==2{printf "Used: %s MB (%.2f%%)\nFree: %s MB (%.2f%%)\nTotal: %s MB\n", $3, $3*100/$2, $4, $4*100/$2, $2}'

# Total disk usage
echo -e "\nDisk Usage:"
df -h / | awk '$NF=="/"{printf "Used: %s (%s)\nFree: %s (%s)\nTotal: %s\n", $3, $5, $4, 100-$5, $2}'

# Top 5 processes by CPU usage
echo -e "\nTop 5 Processes by CPU Usage:"
ps aux --sort=-%cpu | head -n 6 | tail -n 5 | awk '{print $11, $3"%"}'

# Top 5 processes by memory usage
echo -e "\nTop 5 Processes by Memory Usage:"
ps aux --sort=-%mem | head -n 6 | tail -n 5 | awk '{print $11, $4"%"}'

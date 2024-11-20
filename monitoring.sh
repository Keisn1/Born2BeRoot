#!/usr/bin/env bash

echo "#Architecture: $(uname -a)"

physical_CPUS=$(lscpu | grep "Socket(s):" | awk '{print $2}')
echo "#CPU physical: $physical_CPUS"

virtual_CPUS=$(lscpu | grep "^CPU(s):" | awk '{print $2}')
echo "#vCPU: $virtual_CPUS"

usedRAM=$(free -m | awk 'NR==2 {print $3}')
totalRAM=$(free -m | awk 'NR==2 {print $2}')
used_perc=$(awk "BEGIN {printf \"%.1f\", ($usedRAM / $totalRAM) * 100}")
echo "#Memory Usage: ${usedRAM}/${totalRAM} (${used_perc})%"

fdisk_mb=$(df -BM | grep "^/dev/mapper/LVMGroup" | awk '{ sum += $2 } END { print sum }')
fdisk_gb=$(awk "BEGIN {printf \"%.1f\", ($fdisk_mb / 1024)}")
udisk_mb=$(df -BM | grep "^/dev/mapper/LVMGroup" | awk '{ sum += $3 } END { print sum }')
udisk_perc=$(awk "BEGIN { printf \"%.1f\", ($udisk_mb / $fdisk_mb * 100) }")
echo "#Disk Usage: ${fdisk_mb}/${fdisk_gb}GB (${udisk_perc}%)"

cpu_load=$(top -bn1 | grep "%Cpu" | awk '{printf("%.1f\n", $2 + $4 + $6)}')
echo "#CPU load: ${cpu_load}%"

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

date_last_reboot=$(last reboot --time-format iso  | head -n 1 | awk '{print $5}' | cut -d 'T' -f 1)
time_last_reboot=$(last reboot --time-format iso  | head -n 1 | awk '{print $5}' | cut -d 'T' -f 2 | cut -d '+' -f 1 | cut -c -5)
echo "#Last boot: $date_last_reboot $time_last_reboot"

lvm_active=$(lsblk | grep "lvm" | wc -l | awk '{if ($1 > 0) {print "yes"} else {print "no"}}')
echo "#LVM use: $lvm_active"

tcp_conns=$(ss -tn | grep ESTAB | wc -l)
echo "#Connections TCP: ${tcp_conns} ESTABLISHED"

users_logged=$(users | wc -w)
echo "#User log: $users_logged"

ipv4=$(ip address show $(ip route show default | cut -d ' ' -f5) | grep 'inet ' | awk '{print $2}' | cut -d '/' -f1)
ipv6=$(ip address show $(ip route show default | cut -d ' ' -f5) | grep 'inet6' | awk '{print $2}' | cut -d '/' -f1)
echo "#Network: IP $ipv4 ($ipv6)"

sudos=$(journalctl _COMM=sudo | grep -c 'COMMAND')
echo "#Sudo : ${sudos}"

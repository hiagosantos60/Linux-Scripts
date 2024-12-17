#!/bin/bash
# server-status.sh

export LANG=en_US.UTF-8

if [[ $(id -u) -ne 0 ]]; then
    echo "Você não está como Superuser. Parando script!"
    exit 1
fi

echo "==== CPU Usage ===="
top -b -n 1 | head -n 3

echo "                                    "

echo "==== Top 5 processes by CPU usage ===="
ps aux --sort=-%mem | head -n 6 | awk '{print $1, $2, $3, $4, $11}'

echo "                                    "

echo "==== Total Memory Usage ===="
free -h | awk 'NR==2{print "Total:", $2 " | Used:", $3 " | Free:", $4 " | Percent Used:", $3/$2*100 "%"}'

echo "                                    "

echo "==== Total Disk Usage ===="
df -h | grep '^/dev' | awk '{print $1 "| Total:", $2 " | Free:", $4 " | Used:", $3 " | Percent Used:", $5}' 
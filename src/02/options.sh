#!/bin/bash

HOSTNAME=$(sudo hostnamectl hostname)
TIMEZONE=$(sudo timedatectl | grep "Time zone" | awk '{print $3 " " $4 " " $5}')
USER=$(whoami)
OS=$(sudo hostnamectl | grep "Operating System:" | awk '{print $3 " " $4 " " $5}')
DATE=$(date | awk '{$1=$6=""; print $0}')
UPTIME=$(uptime -p | awk '{$1=""; print $0}')
UPTIME_SEC=$(cat /proc/uptime | awk '{print $1}')
IP=$(hostname -I | awk '{print $1}')
MASK=$(ifconfig | grep "$IP" | awk '{print $4}')
GATEWAY=$(ip r | grep default | awk '{print $3}')
RAM_TOTAL=$(free | grep Mem | awk '{printf "%.3f GB", $2/1000000}')
RAM_USED=$(free | grep Mem | awk '{printf "%.3f GB", $3/1000000}')
RAM_FREE=$(free | grep Mem | awk '{printf "%.3f GB", $4/1000000}')
SPACE_ROOT=$(df | grep /dev/sda2 | awk '{printf "%.2f MB", $2/1024}')
SPACE_ROOT_USED=$(df | grep /dev/sda2 | awk '{printf "%.2f MB", $3/1024}')
SPACE_ROOT_FREE=$(df | grep /dev/sda2 | awk '{printf "%.2f MB", $4/1024}')

echo "HOSTNAME = $HOSTNAME"
echo "TIMEZONE = $TIMEZONE"
echo "USER = $USER"
echo "OS = $OS"
echo "DATE =$DATE"
echo "UPTIME =$UPTIME"
echo "UPTIME_SEC = $UPTIME_SEC"
echo "IP = $IP"
echo "MASK = $MASK"
echo "GATEWAY = $GATEWAY"
echo "RAM_TOTAL = $RAM_TOTAL"
echo "RAM_USED = $RAM_USED"
echo "RAM_FREE = $RAM_FREE"
echo "SPACE_ROOT = $SPACE_ROOT"
echo "SPACE_ROOT_USED = $SPACE_ROOT_USED"
echo "SPACE_ROOT_FREE = $SPACE_ROOT_FREE"
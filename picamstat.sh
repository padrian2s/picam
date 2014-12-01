#!/bin/bash

t=0

while true; do
 echo "wait 5m..."
 sleep 5m
 ping -c 1 www.youtube.com &>/dev/null
 if [ "$?" = 0 ]; then
    echo "is alive"
    echo go >/home/pi/picam/pistat
 else
    if (( $t>40 )); then
      echo "reboot"
      echo $(date) >> /home/pi/picam/reboots
      reboot
    fi
    echo "is not alive"
    echo wait >/home/pi/picam/pistat
    t=$((t+1))
    #echo $t
 fi
done
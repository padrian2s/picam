#!/bin/bash
while true; do

H=$(date +%H)
if ((6 <= 10#$H && 10#$H < 17)); then
 echo $(date) > /home/pi/picam/working
 sleep 1m
fi



done

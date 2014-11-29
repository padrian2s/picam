#!/bin/bash
while true; do

H=$(date +%H)
echo $H $(date)
if (( 6 <= 10#$H && 10#$H < 174)); then
 echo $(date) >> /home/pi/picam/working
 filename=$(date -u +"%d%m%Y_%H%M").jpg
# /usr/bin/raspivid -n -t 60000*60 -o /home/pi/picam/tlcam.avi -fps 2
 /usr/bin/raspivid -n -v -t 3600000 -o /home/pi/picam/tlcam.avi -fps 2
 echo $(date) >> /home/pi/picam/menc
 mv /home/pi/picam/tlcam.avi /home/pi/picam/tlcam2.avi
 python /home/pi/picam/youtube/upload_video.py --file=/home/pi/picam/tlcam2.avi --title="Video Title $(date)"  --noauth_local_webserver &
 rm jpg/*.jpg
else

 sleep 1m

fi



done

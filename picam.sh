#!/bin/bash

rectime=$((60000*60))

while true; do

    picam=$(cat /home/pi/picam/pistat)
    if [ "$picam" == "wait" ]; then
     echo "...........WAIT.............."
     sleep 1m
    else
	H=$(date +%H)
	echo $H $(date)
	if (( 6 <= 10#$H && 10#$H < 17)); then
	 echo rectime=$rectime - $(date) >> /home/pi/picam/working
	 filename=$(date +"%d%m%Y_%H_%M")
	 #mkdir /home/pi/picam/jpg/$filename 2>/dev/null
	 mkdir /home/pi/picam/tmp/$filename 2>/dev/null
	 /usr/bin/raspistill -w 1366 -h 766 -n -t $rectime -tl 6000 -o /home/pi/picam/tmp/$filename/a%d.jpg 2>/home/pi/picam/picam.err 1>/home/pi/picam.ok
	 ln -s /home/pi/picam/tmp/$filename /home/pi/picam/jpg/$filename
	else
	 echo sleep mod 1m
	 sleep 1m
	fi
    fi

done

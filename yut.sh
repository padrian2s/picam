#!/bin/bash

#exit
jpg="jpg"

while true; do

picam=$(cat /home/pi/picam/pistat)
if [ "$picam" == "wait" ]; then
 echo "...........WAIT.............."
 sleep 1m
else
 for D in `ls -tr /home/pi/picam/mpg/*.avi  2>/dev/null`
 do
     sz=$(ls -1 $D 2>/dev/null | wc -l)
     echo $D ----- $sz
     if ((10#$sz >= 1)); then
       bfn=`basename $D`
       isOpen=$(lsof | grep $bfn | wc -l)
       echo isOpen = $isOpen --- bfn = $bfn
	if ((10#$isOpen == 0)); then
	    echo "I have something to upload..."
	    echo $(date)
	    cat /dev/null >/home/pi/picam/yut.ok
	    python /home/pi/picam/youtube/upload_video.py --file=$D --title="Video Title $(date)"  --noauth_local_webserver 1>/home/pi/picam/yut.ok 2>/home/pi/picam/yut.err
	    yutret=$(cat /home/pi/picam/yut.ok | grep succ | wc -l)
	    if [ "$yutret" == "1" ]; then
		echo "posted successfully on youtube, delete $D"
		rm $D 2>/dev/null
		echo $(date)
	    fi
	fi
	break
     fi
 done
 echo "Sleep..."
 sleep 10s
fi

done
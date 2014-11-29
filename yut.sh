#!/bin/bash

#exit
jpg="jpg"

while true; do
 
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
	    python /home/pi/picam/youtube/upload_video.py --file=$D --title="Video Title $(date)"  --noauth_local_webserver 1>/home/pi/picam/yut.ok 2>/home/pi/picam/yut.err
	    rm $D 2>/dev/null
	    echo $(date)
	fi

 	break
     fi
 done
 echo "Sleep..."
 sleep 10s
done
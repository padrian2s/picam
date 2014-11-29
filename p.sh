#!/bin/bash

#exit
jpg="jpg"

while true; do
 
 filename=$(date -u +"%d%m%Y_%H%M")
 #echo Current filename:"$filename"
 #echo "-----------------------------------"
 

 for D in `find /home/pi/picam/jpg -type l 2>/dev/null`
 do
     sz=$(ls -tr -1 $D/*.jpg 2>/dev/null| wc -l)
     echo Total files "$sz" - $D
     if ((10#$sz >= 10)); then
 	echo "I have work to do"
 	ls -tr -d -1 "$D"/*.jpg > "$D"/a.txt
 	mencoder -nosound -ovc lavc -lavcopts vcodec=mpeg4:aspect=16/9:vbitrate=8000000 -vf scale=1366:766 -o /home/pi/picam/mpg/tlcam"$filename".avi -mf type=jpeg:fps=24 mf://@$D/a.txt 1>/home/pi/picam/menc.ok 2>/home/pi/picam/menc.err
	rm $D/*.jpg 2>/dev/null
 	break
     fi

     if ((10#$sz == 0)); then
	bsn=`basename $D`
	rm -R /home/pi/picam/tmp/$bsn
        rm -R $D
	echo deleted $bsn
     fi
 done
 echo "Sleep..."
 sleep 3s
done
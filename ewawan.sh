#!/bin/bash -x
# This file is used to initiate the Expect script, which does the peer connection testing.
# Once that peer test finishes, this file continues by checking the output of the log file
# generated, and determines if the process ran successfully. If NOT, then an email is sent.
# If the process does run successfully, a log enty will suffice.
# This file is called to run by /etc/crontab, to be run at some interval of your choosing.
#
#
export PATH=/usr/local/sbin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin

rm /home/kc7aad/ewawan.log
dt=`date '+%D %T'`
sudo expect /home/kc7aad/ewawan.exp >> /home/kc7aad/ewawan.log

if grep -q "Connected to PULL96-1" /home/kc7aad/ewawan.log
   then
     echo "$dt - 9600 baud connection is successful" >> /home/kc7aad/packet.log
else
     echo "$dt - 9600 baud connection has Failed!!!" >> /home/kc7aad/packet.log;mail -s 'EWAWAN:K7TJ-9 Failed to connected via 9600 Baud on RF' <yourmail>@gmail.com
fi
sudo cp /home/kc7aad/packet.log /var/www/html/packet.txt



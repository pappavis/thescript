#!/bin/bash
# http://cagewebdev.com/raspberry-pi-getting-audio-working/
LOGFILE=/home/pi/logs/installGeluid-`date +%Y-%m-%d_%Hh%Mm`.log

echo "" 2>&1 | tee -a $LOGFILE
echo "$datum Start installGeluid" 2>&1 | tee -a $LOGFILE

sudo apt-get install -y alsa-utils mpg321 lame 2>&1 | tee -a $LOGFILE
sudo modprobe snd-bcm2835 2>&1 | tee -a $LOGFILE
sudo lsmod | grep 2835 2>&1 | tee -a $LOGFILE
sudo amixer cset numid=2 2>&1 | tee -a $LOGFILE
aplay /usr/share/sounds/alsa/Front_Center.wav 2>&1 | tee -a $LOGFILE
echo "$datum Einde installGeluid" 2>&1 | tee -a $LOGFILE

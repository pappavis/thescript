#!/bin/bash
#ref --> https://forums.raspberrypi.com/viewtopic.php?t=221762#p1360381
LOGFILE=/home/pi/logs/swap_opruimen.log

echo "" 2>&1 | tee -a $LOGFILE
echo "Start swap opschonen $(date)" 2>&1 | tee -a $LOGFILE
sudo sync 2>&1 | tee -a $LOGFILE
sudo swapoff -a 2>&1 | tee -a $LOGFILE
sudo swapon /var/swap 2>&1 | tee -a $LOGFILE
free 2>&1 | tee -a $LOGFILE
echo "EINDE swap opschonen $(date)" 2>&1 | tee -a $LOGFILE

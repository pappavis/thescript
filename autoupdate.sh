#!/bin/bash
mkdir /home/pi/logs
LOGFILE=$HOME/logs/autoupdate-`date +%Y-%m-%d_%Hh%Mm`.log

echo "" 2>&1 | tee -a $LOGFILE
echo "Start autoupdate" 2>&1 | tee -a $LOGFILE
sudo apt-get update -y
sudo apt-get upgrade -y  2>&1 | tee -a $LOGFILE
sudo rpi-update -y 2>&1 | tee -a $LOGFILE
sudo apt-get autoremove -y 2>&1 | tee -a $LOGFILE
sudo apt-get autoclean -y 2>&1 | tee -a $LOGFILE
echo "Einde autoupdate" 2>&1 | tee -a $LOGFILE
sudo reboot

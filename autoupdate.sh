#!/bin/bash
_cd=$(pwd)
mkdir /home/pi/logs
LOGFILE=$HOME/logs/autoupdate-`date +%Y-%m-%d_%Hh%Mm`.log

echo "" 2>&1 | tee -a $LOGFILE
echo "Start autoupdate" 2>&1 | tee -a $LOGFILE
if [ -f /home/pi/pi-apps ]; then
    echo "Start pi-apps update" 2>&1 | tee -a $LOGFILE
    cd /home/pi/pi-apps
    git pull 2>&1 | tee -a $LOGFILE
fi
sudo apt-get update -y | tee -a $LOGFILE
sudo apt-get upgrade -y  2>&1 | tee -a $LOGFILE
sudo rpi-update -y 2>&1 | tee -a $LOGFILE
sudo apt-get autoremove -y 2>&1 | tee -a $LOGFILE
sudo apt-get autoclean -y 2>&1 | tee -a $LOGFILE
echo "Einde autoupdate" 2>&1 | tee -a $LOGFILE
sudo reboot

#!/bin/bash
# 20220104 je kunt deze autoupdate.sh kopieeren naar /etc/cron.weekly
_cd=$(pwd)
mkdir /home/pi/logs
LOGFILE=/home/pi/logs/autoupdate-`date +%Y-%m-%d_%Hh%Mm`.log
datum=(`date +%Y-%m-%d_%Hh%Mm`)

echo "" 2>&1 | tee -a $LOGFILE
echo "$datum Start autoupdate" 2>&1 | tee -a $LOGFILE

cd /home/pi/Downloads/thescript
git pull 2>&1 | tee -a $LOGFILE
cd $_cd

if [ -f /home/pi/pi-apps ]; then
    echo "$datum Start pi-apps update" 2>&1 | tee -a $LOGFILE
    cd /home/pi/pi-apps
    git pull 2>&1 | tee -a $LOGFILE
    /home/pi/pi-apps/updater | tee -a $LOGFILE
fi

REBOOTJPG=/home/pi/logs/rebootPlaatje-`date +%Y-%m-%d_%Hh%Mm`.jpg
fswebcam -r 1280x720 --no-banner $REBOOTJPG 2>&1 | tee -a $LOGFILE

sudo apt-get update -y | tee -a $LOGFILE
sudo apt-get upgrade -y  2>&1 | tee -a $LOGFILE
sudo rpi-update -y 2>&1 | tee -a $LOGFILE
sudo apt-get autoremove -y 2>&1 | tee -a $LOGFILE
sudo apt-get autoclean -y 2>&1 | tee -a $LOGFILE
sudo npm install -g npm-check-updates 2>&1 | tee -a $LOGFILE
sudo ncu --upgrade 2>&1 | tee -a $LOGFILE
sudo npm install -g 2>&1 | tee -a $LOGFILE
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python

# NPM & node altijd actueel bijgewerkt
sudo n latest 2>&1 | tee -a $LOGFILE

sudo cp /home/pi/Downloads/thescript/index_apps.php /var/www/html 2>&1 | tee -a $LOGFILE

echo "$datum Einde autoupdate" 2>&1 | tee -a $LOGFILE
sudo reboot

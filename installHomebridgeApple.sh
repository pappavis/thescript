#!/bin/bash
_hn1=$(hostname)
LOGFILE=$HOME/logs/installHomebridgeApple-`date +%Y-%m-%d_%Hh%Mm`.log

echo "" 2>&1 | tee -a $LOGFILE
echo "Start installatie homebridge voor Apple homekit." 2>&1 | tee -a $LOGFILE
echo "Zie ook https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Raspbian" 2>&1 | tee -a $LOGFILE

echo "Apple homekit wordt geïnstalleerd op node: $(node -v) en NPM: $(npm -v)." 2>&1 | tee -a $LOGFILE

for addonnodes in homebridge homebridge-config-ui-x ; do 
		echo "--Installeren Apple homekit: \"${addonnodes}\""  2>&1 | tee -a $LOGFILE
		sudo npm install -g --unsafe-perm  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

echo "Homekit als service gestart." 2>&1 | tee -a $LOGFILE
sudo hb-service install --user homebridge 2>&1 | tee -a $LOGFILE
echo "Homekit op http://$_hn1.local:8581, gebruiker=admin, wachtwoord=admin   ook op http://$(hostname -I):8581" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

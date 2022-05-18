#!/bin/bash
_hn1=$(hostname)
LOGFILE=$HOME/logs/installHomebridgeApple-`date +%Y-%m-%d_%Hh%Mm`.log

echo "" 2>&1 | tee -a $LOGFILE
echo "Start installatie homebridge voor Apple homekit." 2>&1 | tee -a $LOGFILE
echo "Zie ook https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Raspbian" 2>&1 | tee -a $LOGFILE

echo "Apple homekit wordt geïnstalleerd op node: $(node -v) en NPM: $(npm -v)." 2>&1 | tee -a $LOGFILE

for addonnodes in homebridge homebridge-config-ui-x ; do 
	echo ""  2>&1 | tee -a $LOGFILE
	echo ""  2>&1 | tee -a $LOGFILE
	echo "--Installeren Apple homekit: \"${addonnodes}\""  2>&1 | tee -a $LOGFILE
	sudo npm install -g --unsafe-perm  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

echo ""  2>&1 | tee -a $LOGFILE

for addonnodes in homebridge-octoprint@latest  homebridge-camera-ffmpeg  @jappyjan/homebridge-wled  homebridge-neopixel  homebridge-domoticz-selector-switch homebridge-tasmota  @credding/homebridge-sonos  homebridge-smarthome  homebridge-apple-tv homebridge-nest-google homebridge-camera-ui  @oscar_penelo/homebridge-camera-ffmpeg-2way  homebridge-doorbell-telegram-photo  homebridge-website-to-camera  homebridge-mqttthing  homebridge-rpi homebridge-p1  homekit-code  homebridge-ring  @homebridge/bluetooth-hci-socket homebridge-ikea-tradfri-gateway  homebridge-weather  homebridge-bravia  homebridge-samsungtv-control  homebridge-calendar  homebridge-ewelink  homebridge-z2m  homebridge-pihole  homebridge-bravia-tvos homebridge-androidtv  homebridge-webos-tv  homebridge-homewizard  homebridge-brewer  homebridge-music  @hoobs/ikea-tradfri  homebridge-alexa  homebridge-website-to-camera  homebridge-playstation  homebridge-noip  ; do 
	echo ""  2>&1 | tee -a $LOGFILE
	echo ""  2>&1 | tee -a $LOGFILE
	echo "--Installeren homekit addon: \"${addonnodes}\""  2>&1 | tee -a $LOGFILE
	sudo -E -n npm install -g ${addonnodes} 2>&1 | tee -a $LOGFILE
done

echo ""  2>&1 | tee -a $LOGFILE
 
echo "Homekit als service gestart." 2>&1 | tee -a $LOGFILE
sudo hb-service install --user homebridge 2>&1 | tee -a $LOGFILE
echo "Genereer een Homebridge QR-code.. ref--> https://www.npmjs.com/package/homekit-code" 2>&1 | tee -a $LOGFILE
npx homekit-code qrcode --category=switch --pairingCode=84131633 --setupId=3QYT 2>&1 | tee -a $LOGFILE
echo "Homekit op http://$_hn1.local:8581, gebruiker=admin, wachtwoord=admin   ook op http://$(hostname -I):8581" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

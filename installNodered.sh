#!/bin/bash
# origineel TheScript door Pete Scargill.
startTime="$(date +%s)"
columns=$(tput cols)
user_response=""
_pwd=$(pwd)
_cpu=$(uname -m)
_cpuChk="armv6l"
ACTIVECORES=$(nproc)

NQUIET=""
skip=0
other=0
MYMENU=$"nodenew"
LOGFILE=$HOME/logs/installNodered-`date +%Y-%m-%d_%Hh%Mm`.log

mkdir ~/logs

printstatus  "**Installer en node-red en modules"
mkdir /home/pi/Downloads
cd ~

printstatus "Oude  nodered  verwijderen"  2>&1 | tee -a $LOGFILE
sudo service nodered stop
printstatus "sudo npm uninstall -g node-red"
printstatus "Opschonen en legen nodered cache"
rm -rf ~/.node-red
printstatus "Opschonen en legen nodered cache afgerond."
mkdir /home/pi/.node-red
cd /home/pi/.node-red

for addonnodes in build-essential libnode72 yarn ; do
	printstatus "Installing lib \"${addonnodes}\""
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo apt --fix-broken install -y 2>&1 | tee -a $LOGFILE
sudo apt -fix-broken build-essential libnode72 -y 2>&1 | tee -a $LOGFILE
sudo apt autoremove -y 2>&1 | tee -a $LOGFILE
sudo apt autoclean -y 2>&1 | tee -a $LOGFILE


##node-red admin init
npm audit fix 2>&1 | tee -a $LOGFILE 2>&1 | tee -a $LOGFILE
sudo npm install -g qrcode  2>&1 | tee -a $LOGFILE
npm install johnny-five 2>&1 | tee -a $LOGFILE

## echo 143.204.15.127 deb.nodesource.com | sudo tee -a /etc/hosts
## curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered > update-nodejs-and-nodered
## chmod +x update-nodejs-and-nodered
## echo y | ./update-nodejs-and-nodered

##sudo npm install -g --unsafe-perm node-red
cd /home/pi/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/settings.js
wget https://raw.githubusercontent.com/pappavis/thescript/master/flows.json
mv ./settings.js /home/pi/.node-red/
mv ./flows.json /home/pi/.node-red/
sed -i -e "s#\/\/var i2c#var i2c#" /home/pi/.node-red/settings.js
sed -i -e "s#\/\/i2c#i2c#" /home/pi/.node-red/settings.js

mkdir ~/Downloads
cd ~/Downloads	
echo "Nodered service installeren"
wget https://raw.githubusercontent.com/pappavis/thescript/master/nodered.service
sudo mv ./nodered.service /etc/systemd/system
sudo systemctl enable nodered.service 2>&1 | tee -a $LOGFILE

echo "Nodered service starten"
sudo service nodered restart

cd && sudo cp /var/log/nodered-install.log . && sudo chown pi.pi ./nodered-install.log && cd ~/.node-red/

cd $_pwd
bash ./installNoderedNodes.sh
sudo service nodered restart

npm $NQUIET install i2c-bus 2>&1 | tee -a $LOGFILE
printstatus "Installing node \"bcryptjs\""
sudo npm $NQUIET install bcryptjs 2>&1 | tee -a $LOGFILE

MYMENU="hwsupport"

if [[ $MYMENU == *"hwsupport"* ]]; then
## this last bit of code is to ensure that node-red-contrib-opi-gpio can gain access to port bits!!
getent group gpio || sudo groupadd gpio 2>&1 | tee -a $LOGFILE
getent group gpio | grep -w -l pi || sudo adduser pi gpio 2>&1 | tee -a $LOGFILE
[ ! -f /etc/udev/rules.d/99-com.rules ] && echo "KERNEL==\"gpio*\", RUN=\"/bin/sh -c 'chgrp -R gpio /sys/%p /sys/class/gpio && chmod -R g+w /sys/%p /sys/class/gpio'\"" | sudo tee -a /etc/udev/rules.d/99-com.rules > /dev/null

if [[ $OPSYS == *"RASPBIAN"* ]]; then
	sudo sed -i -e 's#exit 0#chmod 777 /dev/ttyAMA0\nexit 0#g' /etc/rc.local
	sudo apt-get -y install python{,3}-rpi.gpio 2>&1 | tee -a $LOGFILE
else
	if [[ $MYMENU == *"generich3"* ]]; then
		npm $NQUIET install node-red-contrib-opi-gpio 2>&1 | tee -a $LOGFILE
	fi
fi
sudo sed -i -e 's#exit 0#chmod 777 /dev/ttyS*\nexit 0#g' /etc/rc.local
fi


cd ~/.node-red/
npm $NQUIET audit fix
sudo wget -a $LOGFILE $AQUIET https://tech.scargill.net/iot/settings.txt -O settings.js

## add a nice little command line utility (nrlog) for showing and tailing Node-Red scripts in colour
echo "alias nrlog='sudo journalctl -f -n 50 -u nodered -o cat | ccze -A'" | sudo tee -a /etc/bash.bashrc > /dev/null 2>&1

cd ~/.node-red
npm audit fix --force

cd ~

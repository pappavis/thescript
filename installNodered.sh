#!/bin/bash
# origineel TheScript door Pete Scargill.
startTime="$(date +%s)"
columns=$(tput cols)
user_response=""
_pwd=$(pwd)
_cpu=$(uname -m)
_cpuChk="armv6l"
ACTIVECORES=$(nproc)

# High Intensity
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
NQUIET=""
skip=0
other=0
MYMENU=$"nodenew"
LOGFILE=$HOME/logs/installNodered-`date +%Y-%m-%d_%Hh%Mm`.log

mkdir ~/logs

clean_stdin()
{
    while read -r -t 0; do
        read -n 256 -r -s
    done
}

stopit=0
other=0
yes=0
nohelp=0
hideother=0


CPU_TEMP_CURRENT='Unknown'
CPU_TEMP_PRINT='Unknown'
ACTIVECORES=$(grep -c processor /proc/cpuinfo)

#Array to store possible locations for temp read.
aFP_TEMPERATURE=(
    '/sys/class/thermal/thermal_zone0/temp'
    '/sys/devices/virtual/thermal/thermal_zone1/temp'
    '/sys/devices/platform/sunxi-i2c.0/i2c-0/0-0034/temp1_input'
    '/sys/class/hwmon/hwmon0/device/temp_label'
)

Obtain_Cpu_Temp(){
    for ((i=0; i<${#aFP_TEMPERATURE[@]}; i++))
    do
        if [ -f "${aFP_TEMPERATURE[$i]}" ]; then
            CPU_TEMP_CURRENT=$(cat "${aFP_TEMPERATURE[$i]}")
            # - Some devices (pine) provide 2 digit output, some provide a 5 digit ouput.
            #       So, If the value is over 1000, we can assume it needs converting to 1'c
            if (( $CPU_TEMP_CURRENT == 0 )); then
                continue
            fi
            if (( $CPU_TEMP_CURRENT >= 1000 )); then
                CPU_TEMP_CURRENT=$( echo -e "$CPU_TEMP_CURRENT" | awk '{print $1/1000}' | xargs printf "%0.0f" )
            fi
            if (( $CPU_TEMP_CURRENT >= 70 )); then
                CPU_TEMP_PRINT="\e[91mWarning: $CPU_TEMP_CURRENT'c\e[0m"
                elif (( $CPU_TEMP_CURRENT >= 60 )); then
                CPU_TEMP_PRINT="\e[38;5;202m$CPU_TEMP_CURRENT'c\e[0m"
                elif (( $CPU_TEMP_CURRENT >= 50 )); then
                CPU_TEMP_PRINT="\e[93m$CPU_TEMP_CURRENT'c\e[0m"
                elif (( $CPU_TEMP_CURRENT >= 40 )); then
                CPU_TEMP_PRINT="\e[92m$CPU_TEMP_CURRENT'c\e[0m"
                elif (( $CPU_TEMP_CURRENT >= 30 )); then
                CPU_TEMP_PRINT="\e[96m$CPU_TEMP_CURRENT'c\e[0m"
            else
                CPU_TEMP_PRINT="\e[96m$CPU_TEMP_CURRENT'c\e[0m"
            fi
            break
        fi
    done
}

printl() {
	printf $1
	echo -e $1 >> $LOGFILE
}

printstatus() {
    Obtain_Cpu_Temp
    h=$(($SECONDS/3600));
    m=$((($SECONDS/60)%60));
    s=$(($SECONDS%60));
    printf "\r\n${BIGreen}==\r\n== ${BIYellow}$1"
    printf "\r\n${BIGreen}== ${IBlue}Total: %02dh:%02dm:%02ds Cores: $ACTIVECORES Temperature: $CPU_TEMP_PRINT \r\n${BIGreen}==${IWhite}\r\n\r\n"  $h $m $s;
	echo -e "############################################################" >> $LOGFILE
	echo -e $1 >> $LOGFILE
}


printstatus "Installing NodeJS and NodeRed"

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

for addonnodes in build-essential libnode72 npm node ; do
	printstatus "Installing lib \"${addonnodes}\""
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo apt --fix-broken install -y
sudo apt -fix-broken build-essential libnode72 -y
sudo apt autoremove -y
sudo apt autoclean -y

printstatus "NodeJS installeren"


if [ $(nproc) == 1 ]; then
	printstatus "Bijwerken van NodeJS op een PiZeroW"
		
	wget https://nodejs.org/dist/v17.2.0/node-v17.2.0.tar.gz
	tar xzf ./node-v17.2.0.tar.gz
	cd ./node-v17.2.0.tar.gz
	make clean
	./configure
	make -j1
	sudo make install	
	
	cd ..
	rm -rf node
	cd /home/pi/.node-red

	printstatus  "NodeJS build en install afgerond."
else
	printstatus "laatste versie installeren van NodeJS en NPM" 2>&1 | tee -a $LOGFILE
	cd ~/Downloads
	wget https://nodejs.org/download/release/latest-v17.x/node-v17.3.0-linux-armv7l.tar.gz 2>&1 | tee -a $LOGFILE
	tar xzf ./node-v17.3.0-linux-armv7l.tar.gz
	sudo cp -R -v ./node-v17.3.0-linux-armv7l/* /usr/local/
	sudo chown pi:pi -R /usr/local/lib/node_modules/
	rm -rf ./node-v17.3.0-linux-armv7l*
	printstatus "Installatie NodeJS: $(node -v) en npm $(npm -v) afgerond." 2>&1 | tee -a $LOGFILE
	
	cd /home/pi/.node-red
	echo "y\n" | bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
fi


##node-red admin init
npm audit fix
sudo npm install -g qrcode 
npm install johnny-five
sudo apt-get install -y  yarn


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


cd ~/Downloads
git clone https://github.com/node-red/linux-installers.git 2>&1 | tee -a $LOGFILE
cd linux-installers/pibuild
bash ./node-red-pi-install.sh
bash ./node-red-deb-pack.sh 2>&1 | tee -a $LOGFILE
rm -rf ./linux-installers

cd ~/.node-red/
npm $NQUIET audit fix
sudo wget -a $LOGFILE $AQUIET https://tech.scargill.net/iot/settings.txt -O settings.js

## add a nice little command line utility (nrlog) for showing and tailing Node-Red scripts in colour
echo "alias nrlog='sudo journalctl -f -n 50 -u nodered -o cat | ccze -A'" | sudo tee -a /etc/bash.bashrc > /dev/null 2>&1

cd ~/.node-red
npm audit fix --force

cd ~

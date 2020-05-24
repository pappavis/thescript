OPSYS = "RASPBIAN"
MYMENU == "hwsupport"
LOGFILE=$HOME/$0-`date +%Y-%m-%d_%Hh%Mm`.log
adminpass="rider506"
userpass="rider506"

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

if [[ 1==1 ]]; then
    printstatus "Installing NodeJS and NodeRed"
	
##  bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)
   
    curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered > update-nodejs-and-nodered
    echo 143.204.15.127 deb.nodesource.com | sudo tee -a /etc/hosts
    chmod +x update-nodejs-and-nodered
    echo y | ./update-nodejs-and-nodered
 
cd && sudo cp /var/log/nodered-install.log . && sudo chown pi.pi ./nodered-install.log && cd ~/.node-red/
 


	printstatus "Installing Nodes (could take some time)"
# TAKEN OUT  node-red-contrib-graphs - I dont use it, most likely defunct - no work done on it in 3 years
	for addonnodes in moment node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer \
	node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms node-red-node-geofence node-red-contrib-moment node-red-contrib-particle \
	node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb \
	node-red-contrib-isonline node-red-node-ping node-red-node-random node-red-node-smooth node-red-contrib-npm node-red-node-arduino \
	node-red-contrib-file-function node-red-contrib-boolean-logic node-red-contrib-blynk-ws node-red-contrib-telegrambot node-red-contrib-dsm node-red-contrib-ftp \
	node-red-dashboard node-red-contrib-owntracks node-red-contrib-alexa-local node-red-contrib-amazon-echo node-red-contrib-alexa-notifyme node-red-contrib-heater-controller ; do
		printstatus "Installing node \"${addonnodes}\""
		npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	done
	
	printstatus "Installing node \"node-red-node-sqlite\""
	npm $NQUIET install --unsafe-perm node-red-node-sqlite 2>&1 | tee -a $LOGFILE
	if [[ $MYMENU == *"hwsupport"* ]]; then
	printstatus "Installing node \"i2c-bus\""
        npm $NQUIET install i2c-bus 2>&1 | tee -a $LOGFILE
	fi
	printstatus "Installing node \"bcryptjs\""
    sudo npm $NQUIET install bcryptjs 2>&1 | tee -a $LOGFILE

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

	echo " "
	bcryptadminpass=$(node -e "console.log(require('bcryptjs').hashSync(process.argv[1], 8));" $adminpass)
	bcryptuserpass=$(node -e "console.log(require('bcryptjs').hashSync(process.argv[1], 8));" $userpass)
	# echo Encrypted password: $bcryptpass
	cp settings.js settings.js.bak-pre-crypt

	sed -i -e "s#\/\/adminAuth#adminAuth#" /home/pi/.node-red/settings.js
	sed -i -e "s#\/\/httpNodeAuth#httpNodeAuth#" /home/pi/.node-red/settings.js
	sed -i -e "s#NRUSERNAMEA#$adminname#" /home/pi/.node-red/settings.js
	sed -i -e "s#NRPASSWORDA#$bcryptadminpass#" /home/pi/.node-red/settings.js
	sed -i -e "s#NRUSERNAMEU#$username#" /home/pi/.node-red/settings.js
	sed -i -e "s#NRPASSWORDU#$bcryptuserpass#" /home/pi/.node-red/settings.js
	if [[ $MYMENU == *"hwsupport"* ]]; then
	    sed -i -e "s#\/\/var i2c#var i2c#" /home/pi/.node-red/settings.js
	    sed -i -e "s#\/\/i2c#i2c#" /home/pi/.node-red/settings.js
	fi
    sudo systemctl enable nodered.service 2>&1 | tee -a $LOGFILE
    ## add a nice little command line utility (nrlog) for showing and tailing Node-Red scripts in colour
	echo "alias nrlog='sudo journalctl -f -n 50 -u nodered -o cat | ccze -A'" | sudo tee -a /etc/bash.bashrc > /dev/null 2>&1
fi
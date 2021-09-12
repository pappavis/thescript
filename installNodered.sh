MYMENU=""
LOGFILE="/home/pi/logNoderedinstall.log"
adminpass="rider506"
userpass="rider506"
NQUIET=""


echo "* Node-red bijwerken"
sudo apt-get install -y  yarn
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
echo "NodeJS bijgewerkt.  NodeJS versie: $(node -v), npm $(npm -v)"
rm -rf ~/.node-red/node_modules
mkdir ~/.node-red
cd ~/.node-red
npm install node-red-contrib-sqlitedb node-red-contrib-ttn geofence
npm install
cd ~/
sudo service nodered restart

printstatus "Installing NodeJS and NodeRed"
	
	##  bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)

    bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
 
   	##  curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered > update-nodejs-and-nodered
    echo 143.204.15.127 deb.nodesource.com | sudo tee -a /etc/hosts
    chmod +x update-nodejs-and-nodered
    echo y | ./update-nodejs-and-nodered
 
cd && sudo cp /var/log/nodered-install.log . && sudo chown pi.pi ./nodered-install.log && cd ~/.node-red/
 


	printstatus "Installing Nodes (could take some time)"
# TAKEN OUT  node-red-contrib-graphs - I dont use it, most likely defunct - no work done on it in 3 years
	for addonnodes in moment node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer \
	node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms \
	node-red-node-geofence node-red-contrib-moment node-red-contrib-particle \
	node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb \
	node-red-contrib-home-assistant-websocket node-red-contrib-ibm-watson-iot node-red-contrib-sun-position \
	node-red-contrib-tuya-local node-red-contrib-ui-led node-red-contrib-yr node-red-contrib-aedes \
	node-red-contrib-isonline node-red-node-ping node-red-node-random node-red-node-smooth node-red-contrib-npm node-red-node-arduino \
	node-red-contrib-file-function node-red-contrib-boolean-logic node-red-contrib-blynk-ws node-red-contrib-telegrambot node-red-contrib-dsm node-red-contrib-ftp \
	node-red-dashboard node-red-contrib-owntracks node-red-contrib-alexa-local node-red-contrib-amazon-echo node-red-contrib-alexa-notifyme node-red-contrib-heater-controller ; do
		printstatus "Installing node \"${addonnodes}\""
		npm  install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	done
	
	printstatus "Installing node \"node-red-node-sqlite\""
	npm  install --unsafe-perm node-red-node-sqlite 2>&1 | tee -a $LOGFILE
	if [[ $MYMENU == *"hwsupport"* ]]; then
	printstatus "Installing node \"i2c-bus\""
        npm  install i2c-bus 2>&1 | tee -a $LOGFILE
	fi
	printstatus "Installing node \"bcryptjs\""
    sudo npm  install bcryptjs 2>&1 | tee -a $LOGFILE

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
				npm  install node-red-contrib-opi-gpio 2>&1 | tee -a $LOGFILE
			fi
		fi
		sudo sed -i -e 's#exit 0#chmod 777 /dev/ttyS*\nexit 0#g' /etc/rc.local
	fi
            
	cd ~/.node-red/
    npm  audit fix
	sudo wget https://tech.scargill.net/iot/settings.txt -O settings.js

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
  
  sed -i -e "s#\/\/var i2c#var i2c#" /home/pi/.node-red/settings.js
  sed -i -e "s#\/\/i2c#i2c#" /home/pi/.node-red/settings.js
  
    sudo systemctl enable nodered.service 2>&1 | tee -a $LOGFILE
    ## add a nice little command line utility (nrlog) for showing and tailing Node-Red scripts in colour
	echo "alias nrlog='sudo journalctl -f -n 50 -u nodered -o cat | ccze -A'" | sudo tee -a /etc/bash.bashrc > /dev/null 2>&1


    printstatus "Installing Node-Red"
    # if nodejs does not exist, abort node-red install
    if [ -f /usr/bin/node ] || [ -f /usr/local/bin/node ]; then
        # prevent double additions to settings.js if it exists and is already modified
        if [ $(grep public ~/.node-red/settings.js 2> /dev/null | wc -l) -ne 1 ]; then
            # sudo npm $NQUIET install -g npm node-gyp node-pre-gyp 2>&1 | tee -a $LOGFILE
            sudo npm install -g --unsafe-perm node-red 2>&1 | tee -a $LOGFILE
            if [[ $MYMENU == *"phone"* ]]; then
                sudo wget -a $LOGFILE -O /etc/init.d/nodered https://gist.githubusercontent.com/bigmonkeyboy/9962293/raw/0fe19671b1aef8e56cbcb20f6677173f8495e539/nodered
                sudo chmod 755 /etc/init.d/nodered && sudo update-rc.d nodered defaults 2>&1 | tee -a $LOGFILE
            else
                echo | openssl s_client -showcerts -servername raw.githubusercontent.com -connect raw.githubusercontent.com:443 2>/dev/null | openssl x509 -inform pem -noout -text > /dev/null 2>&1
                [[ $? -ne 0 ]] && echo 151.101.128.133 raw.githubusercontent.com | sudo tee -a /etc/hosts
                sudo wget -a $LOGFILE --no-check-certificate https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/nodered.service -O /lib/systemd/system/nodered.service
                sudo wget -a $LOGFILE --no-check-certificate https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/node-red-start -O /usr/bin/node-red-start
                sudo wget -a $LOGFILE --no-check-certificate https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/node-red-stop -O /usr/bin/node-red-stop
                #sudo sed -i -e 's#=pi#=%USER#g' /lib/systemd/system/nodered.service
                sudo chmod +x /usr/bin/node-red-st*
                sudo systemctl daemon-reload 2>&1 | tee -a $LOGFILE
            fi
            
            cd
            mkdir .node-red
            cd .node-red
            printstatus "Installing Nodes (could take some time)"
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
		printstatus "Installing nodes \"serialport and i2c-bus\""
		npm $NQUIET install node-red-node-serialport i2c-bus 2>&1 | tee -a $LOGFILE
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
                #npm $NQUIET install node-red-contrib-gpio 2>&1 | tee -a $LOGFILE
                #npm $NQUIET install raspi-io 2>&1 | tee -a $LOGFILE
			else
				if [[ $MYMENU == *"generich3"* ]]; then
					npm $NQUIET install node-red-contrib-opi-gpio 2>&1 | tee -a $LOGFILE
				fi
            fi
		sudo sed -i -e 's#exit 0#chmod 777 /dev/ttyS*\nexit 0#g' /etc/rc.local
	fi
            
            cd ~/.node-red/
	 		sudo wget -a $LOGFILE $AQUIET https://tech.scargill.net/iot/settings.txt -O settings.js

            #sudo service nodered start 2>&1 | tee -a $LOGFILE
			#while [ ! -f settings.js ] ; do sudo sleep 1 ; done
			#sudo service nodered stop  2>&1 | tee -a $LOGFILE
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

        else
            printl "${IRed}!!!! Settings.JS already present and modified, skipping! ${IWhite}\r\n"
        fi
        #sed -i -e 's#\/\/\s*var fs = require("fs");#var fs = require("fs");\nvar i2c = require("i2c-bus");#' /home/pi/.node-red/settings.js
		## The next two lines are new (Sept 2017) and change the flows files to non-host-specific names - good for copying
		#sed -i -e 's#\/\/flowFile#flowFile#' /home/pi/.node-red/settings.js
        #sed -i -e 's#\/\/flowFilePretty#flowFilePretty#' /home/pi/.node-red/settings.js
		#sed -i -e 's#\/\/ Customising#},\n\n    \/\/ Customising#' /home/pi/.node-red/settings.js
        if [[ $MYMENU == *"phone"* ]]; then
            cd && sudo mv /etc/init.d/sendsigs .
        else
            sudo systemctl enable nodered.service 2>&1 | tee -a $LOGFILE
        fi
		## add a nice little command line utility (nrlog) for showing and tailing Node-Red scripts in colour
	    echo "alias nrlog='sudo journalctl -f -n 50 -u nodered -o cat | ccze -A'" | sudo tee -a /etc/bash.bashrc > /dev/null 2>&1
    else
        printl "${IRed}!!!! Node-Red not installed! ${IWhite}\r\n"
    fi



echo "Nodered install afgerond."



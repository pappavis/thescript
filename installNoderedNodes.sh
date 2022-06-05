NQUIET=''
startTime="$(date +%s)"
LOGFILE=$HOME/logs/installNoderedNodes-`date +%Y-%m-%d_%Hh%Mm`.log
_pwd=$(pwd)
mkdir $HOME/logs

echo "**Installing Nodes (could take some time)" 2>&1 | tee -a $LOGFILE
mkdir ~/.node-red 2>&1 | tee -a $LOGFILE
cd ~/.node-red 2>&1 | tee -a $LOGFILE

bash ./installNutsfuncties.sh 2>&1 | tee -a $LOGFILE

echo "bepalen laatste versies van lokale NPM packages in /home/pi/.node-red/" 2>&1 | tee -a $LOGFILE
npm outdated 2>&1 | tee -a $LOGFILE

for addonnodes in  node-uuid uuid tar ; do
	echo "Updating node \"${addonnodes}\""
	npm $NQUIET update --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

##sudo npm install -g npm-check-updates 2>&1 | tee -a $LOGFILE
##sudo ncu -u 2>&1 | tee -a $LOGFILE
##sudo npm update -g 2>&1 | tee -a $LOGFILE


echo "\nInstalling node \"node-red-node-sqlite\"\n"
npm $NQUIET install --save node-red-node-sqlite 2>&1 | tee -a $LOGFILE

sudo service nodered restart 2>&1 | tee -a $LOGFILE

for addonnodes in node-red-node-serialport i2c-bus ; do
	echo "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done
npm audit fix --force 2>&1 | tee -a $LOGFILE

mv /home/pi/.node-red/node_modules/decamelize /home/pi/.node-red/node_modules/.cliui-vZao9zi8

# TAKEN OUT  node-red-contrib-graphs - I dont use it, most likely defunct - no work done on it in 3 years
for addonnodes in moment  node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

sudo service nodered restart

for addonnodes in moment node-red-node-geofence node-red-contrib-moment node-red-contrib-particle ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

mv /home/pi/.node-red/node_modules/decamelize /home/pi/.node-red/node_modules/.cliui-vZao9zi8

for addonnodes in moment node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

sudo service nodered restart 2>&1 | tee -a $LOGFILE

for addonnodes in moment node-red-contrib-home-assistant-websocket node-red-contrib-ibm-watson-iot node-red-contrib-sun-position ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-contrib-tuya-local node-red-contrib-ui-led node-red-contrib-yr node-red-contrib-aedes ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

sudo service nodered restart 2>&1 | tee -a $LOGFILE

for addonnodes in moment node-red-dashboard node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer \
	node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms \
	node-red-node-geofence node-red-contrib-moment node-red-contrib-particle node-red-contrib-find-my-iphone node-red-contrib-influxdb  \
	node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb \
	node-red-contrib-home-assistant-websocket node-red-contrib-ibm-watson-iot node-red-contrib-sun-position \
	node-red-contrib-tuya-local node-red-contrib-ui-led node-red-contrib-yr node-red-contrib-aedes \
	node-red-contrib-isonline node-red-node-ping node-red-node-random node-red-node-smooth node-red-contrib-npm node-red-node-arduino \
	node-red-contrib-file-function node-red-contrib-boolean-logic node-red-contrib-blynk-ws node-red-contrib-telegrambot node-red-contrib-dsm node-red-contrib-ftp \
	node-red-dashboard node-red-contrib-owntracks node-red-contrib-alexa-local node-red-contrib-amazon-echo node-red-contrib-alexa-notifyme node-red-contrib-heater-controller node-red-contrib-oauth2 ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

sudo service nodered restart

for addonnodes in moment node-red-contrib-find-my-iphone node-red-contrib-ttn node-red-contrib-apple-find-me node-red-contrib-msnodesql   ; do 
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
 
for addonnodes in 	node-red-contrib-homekit-bridged node-red-contrib-homebridge-automation write-excel-file node-red-contrib-web-worldmap node-red-contrib-oauth2   ; do 
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
 
for addonnodes in 	node-red-contrib-wled2 node-red-dashboard node-red-node-pi-mcp3008 node-red-contrib-webservices node-red-node-mysql node-red-contrib-car-bmw   ; do 
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
 
for addonnodes in 	node-red-contrib-google-sheets node-red-contrib-plate-detection node-red-contrib-norelite-homeassistant node-red-contrib-tasmota node-red-contrib-node-firebird node-red-contrib-re-postgres  ; do 
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

npm audit fix --force 2>&1 | tee -a $LOGFILE

echo "Installeren global nodes"
for addonnodes in qrcode johnny-five ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

echo "Bijwerken lokale nodes" 2>&1 | tee -a $LOGFILE
npm $NQUIET update 2>&1 | tee -a $LOGFILE

sudo service nodered restart 2>&1 | tee -a $LOGFILE
echo "Nodes installatie afgerond" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
cd $_pwd


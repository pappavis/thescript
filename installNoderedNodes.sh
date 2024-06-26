NQUIET=''
startTime="$(date +%s)"
LOGFILE=$HOME/logs/installNoderedNodes-`date +%Y-%m-%d_%Hh%Mm`.log
_pwd=$(pwd)
mkdir $HOME/logs

bash ./installNutsfuncties.sh 2>&1 | tee -a $LOGFILE

echo "**Installing Nodes (could take some time)" 2>&1 | tee -a $LOGFILE
mkdir ~/.node-red 2>&1 | tee -a $LOGFILE
cd ~/.node-red

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
npm config set python /home/pi/venv/venv/bin/python 2>&1 | tee -a $LOGFILE
sudo npm install -g node-gyp 2>&1 | tee -a $LOGFILE

echo "\nInstalling node \"node-red-node-sqlite\"\n"
npm $NQUIET install --save node-red-node-sqlite 2>&1 | tee -a $LOGFILE

sudo service nodered restart 2>&1 | tee -a $LOGFILE

cd ~/.node-red

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

cd ~/.node-red

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

for addonnodes in moment node-red-contrib-home-assistant-websocket  node-red-contrib-home-assistant-discovery  node-red-contrib-ibm-watson-iot node-red-contrib-sun-position  @mschaeffler/node-red-lora   ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-contrib-tuya-local node-red-contrib-ui-led node-red-contrib-yr node-red-contrib-aedes node-red-node-base64 node-red-contrib-image-output ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
sudo service nodered restart 2>&1 | tee -a $LOGFILE

for addonnodes in moment node-red-dashboard node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer  express webmidi ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
sudo service nodered restart 2>&1 | tee -a $LOGFILE


for addonnodes in node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms  ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
sudo service nodered restart 2>&1 | tee -a $LOGFILE

for addonnodes in node-red-node-geofence node-red-contrib-moment node-red-contrib-particle node-red-contrib-find-my-iphone node-red-contrib-influxdb   ; do
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
sudo service nodered restart 2>&1 | tee -a $LOGFILE

for addonnodes in node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb   ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

for addonnodes in node-red-contrib-home-assistant-websocket node-red-contrib-ibm-watson-iot node-red-contrib-sun-position  ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

for addonnodes in node-red-contrib-tuya-local node-red-contrib-ui-led node-red-contrib-yr node-red-contrib-aedes  ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

for addonnodes in node-red-contrib-isonline node-red-node-ping node-red-node-random node-red-node-smooth node-red-contrib-npm node-red-node-arduino  ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

for addonnodes in node-red-contrib-file-function node-red-contrib-boolean-logic node-red-contrib-blynk-ws node-red-contrib-telegrambot node-red-contrib-dsm node-red-contrib-ftp  ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
	
for addonnodes in node-red-dashboard node-red-contrib-ui-upload  node-red-contrib-ui-digital-clock  node-red-contrib-ui-multistate-switch  node-red-node-ui-table  node-red-node-ui-webcam  node-red-contrib-ui-led  node-red-node-ui-microphone  node-red-contrib-dashboard-sum-bars  ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
sudo service nodered restart


for addonnodes in node-red-contrib-owntracks node-red-contrib-alexa-local node-red-contrib-amazon-echo node-red-contrib-alexa-notifyme node-red-contrib-heater-controller node-red-contrib-oauth2  node-red-contrib-cron-plus smithtek-node-red-lora @lora-contrib/node-red-contrib-payload-parser node-red-contrib-lora-packet-converter  node-red-contrib-zigbee2mqtt  node-red-contrib-postgresql   node-red-contrib-node-firebird \
	node-red-node-pi-unicorn-hat ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
sudo service nodered restart

for addonnodes in moment node-red-contrib-find-my-iphone node-red-contrib-apple-find-me node-red-contrib-msnodesql  node-red-node-daemon   ; do 
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
 
for addonnodes in node-red-contrib-homekit-bridged node-red-contrib-homebridge-automation write-excel-file  node-red-contrib-excelsheets  node-red-contrib-web-worldmap node-red-contrib-oauth2   ; do 
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
 
for addonnodes in node-red-contrib-wled2 node-red-dashboard node-red-node-pi-mcp3008 node-red-contrib-webservices node-red-node-mysql node-red-contrib-car-bmw  node-red-node-email   node-red-contrib-iiot-rpi-gpio  node-red-contrib-gpio node-red-node-pi-gpio   ; do 
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done
 
for addonnodes in node-red-contrib-google-sheets node-red-contrib-plate-detection node-red-contrib-norelite-homeassistant node-red-contrib-tasmota node-red-contrib-node-firebird node-red-contrib-re-postgres  node-red-contrib-chatbot  node-red-contrib-image-output  node-red-contrib-tradfri ; do 
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

# 20221124 Sonoff automatisering
for addonnodes in node-red-contrib-power-monitor  node-red-contrib-ewelink  node-red-contrib-sonoff-lan-mode   node-red-contrib-sonoff-tasmota-enhanced  node-red-contrib-sonoff-server  ; do
	echo "" 2>&1 | tee -a $LOGFILE
	echo "Installing node \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	echo "" 2>&1 | tee -a $LOGFILE
done

npm audit fix --force 2>&1 | tee -a $LOGFILE

echo "Installeren global nodes" 2>&1 | tee -a $LOGFILE
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


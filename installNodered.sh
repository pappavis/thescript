MYMENU=""
LOGFILE="/home/pi/logNoderedinstall.log"
adminpass=""
userpass=""
NQUIET=""


echo "* Node-red bijwerken"
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
sudo systemctl enable nodered.service

#sudo apt-get install -y  yarn
#curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
#sudo apt-get install -y nodejs
echo "NodeJS bijgewerkt.  NodeJS versie: $(node -v), npm $(npm -v)"
#rm -rf ~/.node-red/node_modules
#mkdir ~/.node-red
cd ~/.node-red
npm install node-red-contrib-sqlitedb node-red-contrib-ttn geofence
npm install --unsafe-perm node-red-node-sqlite

npm install moment node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer \
	node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms \
	node-red-node-geofence node-red-contrib-moment node-red-contrib-particle \
	node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb \
	node-red-contrib-home-assistant-websocket node-red-contrib-ibm-watson-iot node-red-contrib-sun-position \
	node-red-contrib-tuya-local node-red-contrib-ui-led node-red-contrib-yr node-red-contrib-aedes \
	node-red-contrib-isonline node-red-node-ping node-red-node-random node-red-node-smooth node-red-contrib-npm node-red-node-arduino \
	node-red-contrib-file-function node-red-contrib-boolean-logic node-red-contrib-blynk-ws node-red-contrib-telegrambot node-red-contrib-dsm node-red-contrib-ftp \
	node-red-dashboard node-red-contrib-owntracks node-red-contrib-alexa-local node-red-contrib-amazon-echo node-red-contrib-alexa-notifyme node-red-contrib-heater-controller 
	node-red-contrib-apple-find-me node-red-contrib-ttn node-red-contrib-lorawan-packet-decrypt-nwkey-appkey node-red-contrib-extract_ttn

npm install i2c-bus
npm install
npm  audit fix
sudo service nodered restart
cd ~/
sudo npm  install bcryptjs

echo "Nodered install afgerond."



MYMENU=""
LOGFILE="/home/pi/logNoderedinstall.log"
adminpass=""
userpass=""
NQUIET=""
_hn1=$(hostname)

echo "* Node-red contrib bijwerken"

sudo apt update -y
sudo apt upgrade -y

npm install i2c-bus

cd ~/.node-red
sudo rm -rf ./node_modules
npm install geofence
npm $NQUIET install --unsafe-perm node-red-node-sqlite
npm install moment node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer 
npm install node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms
npm install 	node-red-node-geofence node-red-contrib-moment node-red-contrib-particle
npm install 	node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb 
npm install 	node-red-contrib-home-assistant-websocket node-red-contrib-ibm-watson-iot node-red-contrib-sun-position 
npm install 	node-red-contrib-tuya-local node-red-contrib-ui-led node-red-contrib-yr node-red-contrib-aedes 
npm install 	node-red-contrib-isonline node-red-node-ping node-red-node-random node-red-node-smooth node-red-contrib-npm node-red-node-arduino 
npm install 	node-red-contrib-file-function node-red-contrib-boolean-logic node-red-contrib-blynk-ws node-red-contrib-telegrambot node-red-contrib-dsm node-red-contrib-ftp 
npm install 	node-red-dashboard node-red-contrib-owntracks node-red-contrib-alexa-local node-red-contrib-amazon-echo node-red-contrib-alexa-notifyme node-red-contrib-heater-controller 
npm install 	node-red-contrib-apple-find-me node-red-contrib-ttn node-red-contrib-lorawan-packet-decrypt-nwkey-appkey node-red-contrib-extract_ttn

npm install
npm  audit fix
sudo service nodered restart
cd ~/
sudo npm  install bcryptjs
sudo systemctl enable nodered.service

echo "Nodered contrib modules install afgerond."
echo "Start dit met: sudo service nodered restart."


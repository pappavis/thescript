MYMENU=""
LOGFILE="/home/pi/logNoderedinstall.log"
adminpass=""
userpass=""
NQUIET=""


echo "* Node-red bijwerken"
#bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)

sudo apt-get install -y  yarn
curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install -y nodejs
echo "NodeJS bijgewerkt.  NodeJS versie: $(node -v), npm $(npm -v)"
sudo npm install -g node-red --unsafe-perm
rm -rf ~/.node-red/node_modules
mkdir ~/.node-red
cd ~/.node-red
npm install node-red-contrib-sqlitedb node-red-contrib-ttn geofence
npm install --unsafe-perm node-red-node-sqlite

sudo systemctl enable nodered.service

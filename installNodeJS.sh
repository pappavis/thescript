MYMENU=""
LOGFILE="/home/pi/logNodeJSinstall.log"
adminpass=""
userpass=""
NQUIET=""


echo "* Node-JS installeren"
echo "Y\n" | bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)

sudo apt-get install -y  yarn
echo "NodeJS bijgewerkt.  NodeJS versie: $(node -v), npm $(npm -v)"
npm install qrcode johnny-five


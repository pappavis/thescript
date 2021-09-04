printf "\nScargill script wordt afgelaai.\n"
cd /home/pi
wget https://bitbucket.org/api/2.0/snippets/scargill/kAR5qG/master/files/script.sh

printf "\nNode-red wachtwoorden worden verwijdert"
cd /home/pi/.node-red/
https://tech.scargill.net/iot/settings.txt -O settings.js
cp settings.js settings.js.bak-pre-crypt

cd /home/pi/Downloads
wget http://www.sensorsiot.org/transferFiles/Pi_Zero_MQTT_Broker/nodeRedUserReset.sh
printf "\nNode-red wachtwoord reset script nodeRedUserReset.sh afgelaai.\n"

printf "\nScargill script afgelaai.\n"

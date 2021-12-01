_hn1=$(hostname -I)
printf "Start installatie homebridge voor Apple homekit.\n"
printf "Zie ook https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Raspbian\n"
sudo apt install -y nodejs gcc g++ make python net-tools
printf "NodeJS versie: "
node -v
printf "\nApple homekit wordt geïnstalleerd.\n"
sudo npm install -g --unsafe-perm homebridge homebridge-config-ui-x
printf "Homekit als service gestart\n"
sudo hb-service install --user homebridge
printf "Homekit op http://$_hn1.local:8581, gebruiker=admin, wachtwoord=admin\n"


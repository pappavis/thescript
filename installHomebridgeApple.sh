_hn1=$(hostname -I)
LOGFILE=$HOME/logs/installHomebridgeApple-`date +%Y-%m-%d_%Hh%Mm`.log

echo "Start installatie homebridge voor Apple homekit." 2>&1 | tee -a $LOGFILE
echo "Zie ook https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Raspbian" 2>&1 | tee -a $LOGFILE

printf "\nApple homekit wordt geïnstalleerd op node: $(node -v) en NPM: $(npm -v).\n" 2>&1 | tee -a $LOGFILE
sudo npm install -g --unsafe-perm homebridge homebridge-config-ui-x
printf "Homekit als service gestart\n" 2>&1 | tee -a $LOGFILE
sudo hb-service install --user homebridge
printf "Homekit op http://$_hn1.local:8581, gebruiker=admin, wachtwoord=admin\n" 2>&1 | tee -a $LOGFILE


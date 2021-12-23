_hn1=$(hostname)
LOGFILE=$HOME/logs/installHomebridgeApple-`date +%Y-%m-%d_%Hh%Mm`.log

echo "Start installatie homebridge voor Apple homekit." 2>&1 | tee -a $LOGFILE
echo "Zie ook https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Raspbian" 2>&1 | tee -a $LOGFILE

echo "\nApple homekit wordt geïnstalleerd op node: $(node -v) en NPM: $(npm -v)." 2>&1 | tee -a $LOGFILE
sudo npm install -g --unsafe-perm homebridge homebridge-config-ui-x
echo "Homekit als service gestart." 2>&1 | tee -a $LOGFILE
sudo hb-service install --user homebridge
echo "Homekit op http://$_hn1.local:8581, gebruiker=admin, wachtwoord=admin   ook op http://$(hostname -I):8581" 2>&1 | tee -a $LOGFILE


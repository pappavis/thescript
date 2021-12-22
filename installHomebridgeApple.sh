_hn1=$(hostname -I)
LOGFILE=$HOME/logs/installHomebridgeApple-`date +%Y-%m-%d_%Hh%Mm`.log

printf "Start installatie homebridge voor Apple homekit.\n"
printf "Zie ook https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Raspbian\n"

echo "Installeren build-essentials"
for addonnodes in build-essential gcc g++ make python3 net-tools ; do
	echo "Installing lib \"${addonnodes}\""
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo apt install --fix-broken -y
sudo apt autoremove -y
sudo apt autoclean -y

printf "\nApple homekit wordt geïnstalleerd op node: $(node -v) en NPM: $(npm -v).\n" 2>&1 | tee -a $LOGFILE
sudo npm install -g --unsafe-perm homebridge homebridge-config-ui-x
printf "Homekit als service gestart\n" 2>&1 | tee -a $LOGFILE
sudo hb-service install --user homebridge
printf "Homekit op http://$_hn1.local:8581, gebruiker=admin, wachtwoord=admin\n" 2>&1 | tee -a $LOGFILE


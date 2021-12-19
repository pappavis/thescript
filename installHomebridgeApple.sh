_hn1=$(hostname -I)
printf "Start installatie homebridge voor Apple homekit.\n"
printf "Zie ook https://github.com/homebridge/homebridge/wiki/Install-Homebridge-on-Raspbian\n"

echo "Installeren build-essentials"
for addonnodes in build-essential libnode72 npm gcc g++ make python3 net-tools ; do
	echo "Installing lib \"${addonnodes}\""
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo apt --fix-broken install -y
sudo apt -fix-broken build-essential libnode72 -y
sudo apt autoremove -y
sudo apt autoclean -y

node -v
printf "\nApple homekit wordt geïnstalleerd.\n"
sudo npm install -g --unsafe-perm homebridge homebridge-config-ui-x
printf "Homekit als service gestart\n"
sudo hb-service install --user homebridge
printf "Homekit op http://$_hn1.local:8581, gebruiker=admin, wachtwoord=admin\n"


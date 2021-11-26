NQUIET=''
startTime="$(date +%s)"
LOGFILE=/home/pi/installNoderedNodes_logs.txt
_pwd=$(pwd)

printstatus() {
    Obtain_Cpu_Temp
    h=$(($SECONDS/3600));
    m=$((($SECONDS/60)%60));
    s=$(($SECONDS%60));
    printf "\r\n${BIGreen}==\r\n== ${BIYellow}$1"
    printf "\r\n${BIGreen}== ${IBlue}Total: %02dh:%02dm:%02ds Cores: $ACTIVECORES Temperature: $CPU_TEMP_PRINT \r\n${BIGreen}==${IWhite}\r\n\r\n"  $h $m $s;
	echo -e "############################################################" >> $LOGFILE
	echo -e $1 >> $LOGFILE
}

echo "**Installing Nodes (could take some time)"
cd /home/pi/.node-red

printstatus "bepalen laatste versies van globale NPM packages"
sudo npm outdated -g
sudo npm update -g
for addonnodes in npm@latest
	printstatus "Bijwerken globale node \"${addonnodes}\""
	sudo npm $NQUIET update -g ${addonnodes} 2>&1 | tee -a $LOGFILE
done

printstatus "bepalen laatste versies van lokale NPM packages in /home/pi/.node-red/"
npm outdated
for addonnodes in node-uuid@latest uuid@latest node-tar tar@latest
	printstatus "Bijwerken lokale node \"${addonnodes}\""
	sudo npm $NQUIET update ${addonnodes} 2>&1 | tee -a $LOGFILE
done

npm install -g npm-check-updates 2>&1 | tee -a $LOGFILE
ncu -u 2>&1 | tee -a $LOGFILE
npm update 2>&1 | tee -a $LOGFILE

printstatus "\nInstalling node \"node-red-node-sqlite\"\n"
npm $NQUIET install --save node-red-node-sqlite 2>&1 | tee -a $LOGFILE
npm audit fix --force
		
# TAKEN OUT  node-red-contrib-graphs - I dont use it, most likely defunct - no work done on it in 3 years
for addonnodes in moment node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer ; do
	printstatus "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms ; do
	printstatus "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-node-geofence node-red-contrib-moment node-red-contrib-particle ; do
	printstatus "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb ; do
	printstatus "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-contrib-home-assistant-websocket node-red-contrib-ibm-watson-iot node-red-contrib-sun-position ; do
	printstatus "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-contrib-tuya-local node-red-contrib-ui-led node-red-contrib-yr node-red-contrib-aedes ; do
	printstatus "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-contrib-isonline node-red-node-ping node-red-node-random node-red-node-smooth node-red-contrib-npm node-red-node-arduino ; do
	printstatus "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-contrib-file-function node-red-contrib-boolean-logic node-red-contrib-blynk-ws node-red-contrib-telegrambot node-red-contrib-dsm node-red-contrib-ftp ; do
	printstatus "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-dashboard node-red-contrib-owntracks node-red-contrib-alexa-local node-red-contrib-amazon-echo node-red-contrib-alexa-notifyme node-red-contrib-heater-controller ; do 
	printstatus "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-contrib-find-my-iphone node-red-contrib-ttn node-red-contrib-apple-find-me node-red-contrib-msnodesql node-red-contrib-homekit-bridged node-red-contrib-homebridge-automation write-excel-file ; do 
	printstatus "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

npm audit fix --force

printstatus "Bijwerken loakel nodes"
npm $NQUIET update 2>&1 | tee -a $LOGFILE

sudo service nodered restart
echo "Nodes installatie afgerond"
cd $_pwd


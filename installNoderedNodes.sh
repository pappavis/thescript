NQUIET=''
startTime="$(date +%s)"
LOGFILE=$HOME/$0-`date +%Y-%m-%d_%Hh%Mm`_installNoderedNodes_logs.log
_pwd=$(pwd)

#Array to store possible locations for temp read.
aFP_TEMPERATURE=(
    '/sys/class/thermal/thermal_zone0/temp'
    '/sys/devices/virtual/thermal/thermal_zone1/temp'
    '/sys/devices/platform/sunxi-i2c.0/i2c-0/0-0034/temp1_input'
    '/sys/class/hwmon/hwmon0/device/temp_label'
)

Obtain_Cpu_Temp(){
    for ((i=0; i<${#aFP_TEMPERATURE[@]}; i++))
    do
        if [ -f "${aFP_TEMPERATURE[$i]}" ]; then
            CPU_TEMP_CURRENT=$(cat "${aFP_TEMPERATURE[$i]}")
            # - Some devices (pine) provide 2 digit output, some provide a 5 digit ouput.
            #       So, If the value is over 1000, we can assume it needs converting to 1'c
            if (( $CPU_TEMP_CURRENT == 0 )); then
                continue
            fi
            if (( $CPU_TEMP_CURRENT >= 1000 )); then
                CPU_TEMP_CURRENT=$( echo -e "$CPU_TEMP_CURRENT" | awk '{print $1/1000}' | xargs printf "%0.0f" )
            fi
            if (( $CPU_TEMP_CURRENT >= 70 )); then
                CPU_TEMP_PRINT="\e[91mWarning: $CPU_TEMP_CURRENT'c\e[0m"
                elif (( $CPU_TEMP_CURRENT >= 60 )); then
                CPU_TEMP_PRINT="\e[38;5;202m$CPU_TEMP_CURRENT'c\e[0m"
                elif (( $CPU_TEMP_CURRENT >= 50 )); then
                CPU_TEMP_PRINT="\e[93m$CPU_TEMP_CURRENT'c\e[0m"
                elif (( $CPU_TEMP_CURRENT >= 40 )); then
                CPU_TEMP_PRINT="\e[92m$CPU_TEMP_CURRENT'c\e[0m"
                elif (( $CPU_TEMP_CURRENT >= 30 )); then
                CPU_TEMP_PRINT="\e[96m$CPU_TEMP_CURRENT'c\e[0m"
            else
                CPU_TEMP_PRINT="\e[96m$CPU_TEMP_CURRENT'c\e[0m"
            fi
            break
        fi
    done
}

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

printstatus "bepalen laatste versies van lokale NPM packages in /home/pi/.node-red/"
npm outdated

for addonnodes in  node-uuid uuid tar ; do
	printstatus "Updating node \"${addonnodes}\""
	npm $NQUIET update --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

##sudo npm install -g npm-check-updates 2>&1 | tee -a $LOGFILE
##sudo ncu -u 2>&1 | tee -a $LOGFILE
##sudo npm update -g 2>&1 | tee -a $LOGFILE

printstatus "\nInstalling node \"node-red-node-sqlite\"\n"
npm $NQUIET install --save node-red-node-sqlite 2>&1 | tee -a $LOGFILE

for addonnodes in node-red-node-serialport i2c-bus ; do
	printstatus "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done
npm audit fix --force

mv /home/pi/.node-red/node_modules/decamelize /home/pi/.node-red/node_modules/.cliui-vZao9zi8

# TAKEN OUT  node-red-contrib-graphs - I dont use it, most likely defunct - no work done on it in 3 years
for addonnodes in moment  node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer ; do
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

mv /home/pi/.node-red/node_modules/decamelize /home/pi/.node-red/node_modules/.cliui-vZao9zi8

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

for addonnodes in moment node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer \
	node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms \
	node-red-node-geofence node-red-contrib-moment node-red-contrib-particle \
	node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb \
	node-red-contrib-home-assistant-websocket node-red-contrib-ibm-watson-iot node-red-contrib-sun-position \
	node-red-contrib-tuya-local node-red-contrib-ui-led node-red-contrib-yr node-red-contrib-aedes \
	node-red-contrib-isonline node-red-node-ping node-red-node-random node-red-node-smooth node-red-contrib-npm node-red-node-arduino \
	node-red-contrib-file-function node-red-contrib-boolean-logic node-red-contrib-blynk-ws node-red-contrib-telegrambot node-red-contrib-dsm node-red-contrib-ftp \
	node-red-dashboard node-red-contrib-owntracks node-red-contrib-alexa-local node-red-contrib-amazon-echo node-red-contrib-alexa-notifyme node-red-contrib-heater-controller ; do
	printstatus "Instelleren node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in moment node-red-contrib-find-my-iphone node-red-contrib-ttn node-red-contrib-apple-find-me node-red-contrib-msnodesql \ 
	node-red-contrib-homekit-bridged node-red-contrib-homebridge-automation write-excel-file node-red-contrib-web-worldmap node-red-contrib-oauth2 \ 
	node-red-contrib-wled2 node-red-dashboard node-red-node-pi-mcp3008 node-red-contrib-webservices node-red-node-mysql node-red-contrib-car-bmw \ 
	node-red-contrib-google-sheets node-red-contrib-plate-detection node-red-contrib-norelite-homeassistant node-red-contrib-tasmota  ; do 
	printstatus "Installing node \"${addonnodes}\""
	npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
done

npm audit fix --force

printstatus "Bijwerken loakel nodes"
npm $NQUIET update 2>&1 | tee -a $LOGFILE

sudo service nodered restart
echo "Nodes installatie afgerond"
cd $_pwd


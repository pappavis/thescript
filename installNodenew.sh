# origineel TheScript door Pete Scargill.

echo "**Installeren node-red en modules"
cd ~

echo "Oude nodered verwijderen"
sudo service nodered stop
sudo npm uninstall -g node-red
echo "Opschonen en legen nodered cache"
rm -rf ~/.nodered
echo "Opschonen en legen nodered cache afgerond."

startTime="$(date +%s)"
columns=$(tput cols)
user_response=""

# High Intensity
IGreen='\e[0;92m'       # Green
IYellow='\e[0;93m'      # Yellow
IBlue='\e[0;94m'        # Blue
ICyan='\e[0;96m'        # Cyan
IWhite='\e[0;97m'       # White

# Bold High Intensity
BIRed='\e[1;91m'        # Red
BIGreen='\e[1;92m'      # Green
BIYellow='\e[1;93m'     # Yellow
BIPurple='\e[1;95m'     # Purple
BIMagenta='\e[1;95m'    # Purple
BICyan='\e[1;96m'       # Cyan
BIWhite='\e[1;97m'      # White

skip=0
other=0
MYMENU=$"nodenew"

clean_stdin()
{
    while read -r -t 0; do
        read -n 256 -r -s
    done
}

# Permanent loop until both passwords are the same..
function user_input {
    local VARIABLE_NAME=${1}
    local VARIABLE_NAME_1="A"
    local VARIABLE_NAME_2="B"
    while true; do
        printf "${BICyan}$2: ${BIWhite}";
        if [ "$3" = "hide" ] ; then
            stty -echo;
        fi
        read VARIABLE_NAME_1;
        stty echo;
        if [ "$3" = "hide" ] ; then
            printf "\n${BICyan}$2 (again) : ${BIWhite}";
            stty -echo;
            read VARIABLE_NAME_2;
            stty echo;
        else
            VARIABLE_NAME_2=$VARIABLE_NAME_1;
        fi
        if [ $VARIABLE_NAME_1 != $VARIABLE_NAME_2 ] ; then
            printf "\n${BIRed}Sorry, did not match!${BIWhite}\n";
        else
            break;
        fi
    done
    readonly ${VARIABLE_NAME}=$VARIABLE_NAME_1;
    if [ "$3" == "hide" ] ; then
        printf "\n";
    fi
}

stopit=0
other=0
yes=0
nohelp=0
hideother=0

timecount(){
    sec=30
    while [ $sec -ge 0 ]; do
        if [ $nohelp -eq 1 ]; then
            
            if [ $hideother -eq 1 ]; then
                printf "${BIPurple}Continue ${BIWhite}y${BIPurple}(es)/${BIWhite}n${BIPurple}(o)/${BIWhite}a${BIPurple}(ll)/${BIWhite}e${BIPurple}(nd)-  ${BIGreen}00:0$min:$sec${BIPurple} remaining\033[0K\r${BIWhite}"
            else
                printf "${BIPurple}Continue ${BIWhite}y${BIPurple}(es)/${BIWhite}o${BIPurple}(ther)/${BIWhite}e${BIPurple}(nd)-  ${BIGreen}00:0$min:$sec${BIPurple} remaining\033[0K\r${BIWhite}"
            fi
        else
            printf "${BIPurple}Continue ${BIWhite}y${BIPurple}(es)/${BIWhite}h${BIPurple}(elp)-  ${BIGreen}00:0$min:$sec${BIPurple} remaining\033[0K\r${BIWhite}"
        fi
        sec=$((sec-1))
        trap '' 2
        stty -echo
        read -t 1 -n 1 user_response
        stty echo
        trap - 2
        if [ -n  "$user_response" ]; then
            break
        fi
    done
}


task_start(){
    printf "\r\n"
    printf "${BIGreen}%*s\n" $columns | tr ' ' -
    printf "$1"
    clean_stdin
    skip=0
    printf "\n${BIGreen}%*s${BIWhite}\n" $columns | tr ' ' -
    elapsedTime="$(($(date +%s)-startTime))"
    printf "Elapsed: %02d hrs %02d mins %02d secs\n" "$((elapsedTime/3600%24))" "$((elapsedTime/60%60))" "$((elapsedTime%60))"
    clean_stdin
    if [ "$user_response" != "a" ]; then
        timecount
    fi
    echo -e "                                                                        \033[0K\r"
    if  [ "$user_response" = "e" ]; then
        printf "${BIWhite}"
        exit 1
    fi
    if  [ "$user_response" = "n" ]; then
        skip=1
    fi
    if  [ "$user_response" = "o" ]; then
        other=1
    fi
    if  [ "$user_response" = "h" ]; then
        stopit=1
    fi
    if  [ "$user_response" = "y" ]; then
        yes=1
    fi
    if [ -n  "$2" ]; then
        if [ $skip -eq 0 ]; then
            printf "${BIYellow}$2${BIWhite}\n"
        else
            printf "${BICyan}%*s${BIWhite}\n" $columns '[SKIPPED]'
        fi
    fi
}

task_end(){
    printf "${BICyan}%*s${BIWhite}\n" $columns '[OK]'
}


CPU_TEMP_CURRENT='Unknown'
CPU_TEMP_PRINT='Unknown'
ACTIVECORES=$(grep -c processor /proc/cpuinfo)

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

LOGFILE=$HOME/$0-`date +%Y-%m-%d_%Hh%Mm`.log

printl() {
	printf $1
	echo -e $1 >> $LOGFILE
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


if [[ $MYMENU == *"nodenew"* ]]; then
    printstatus "Installing NodeJS and NodeRed"
	
	##  bash <(curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered)

    bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)
 
   	##  curl -sL https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/update-nodejs-and-nodered > update-nodejs-and-nodered
    echo 143.204.15.127 deb.nodesource.com | sudo tee -a /etc/hosts
    chmod +x update-nodejs-and-nodered
    echo y | ./update-nodejs-and-nodered
 
cd && sudo cp /var/log/nodered-install.log . && sudo chown pi.pi ./nodered-install.log && cd ~/.node-red/
 


	printstatus "Installing Nodes (could take some time)"

  printstatus "Installing node \"node-red-node-sqlite\""
	npm $NQUIET install --unsafe-perm node-red-node-sqlite 2>&1 | tee -a $LOGFILE
  
  
# TAKEN OUT  node-red-contrib-graphs - I dont use it, most likely defunct - no work done on it in 3 years
	for addonnodes in moment node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer \
	node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms \
	node-red-node-geofence node-red-contrib-moment node-red-contrib-particle \
	node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb \
	node-red-contrib-home-assistant-websocket node-red-contrib-ibm-watson-iot node-red-contrib-sun-position \
	node-red-contrib-tuya-local node-red-contrib-ui-led node-red-contrib-yr node-red-contrib-aedes \
	node-red-contrib-isonline node-red-node-ping node-red-node-random node-red-node-smooth node-red-contrib-npm node-red-node-arduino \
	node-red-contrib-file-function node-red-contrib-boolean-logic node-red-contrib-blynk-ws node-red-contrib-telegrambot node-red-contrib-dsm node-red-contrib-ftp \
	node-red-dashboard node-red-contrib-owntracks node-red-contrib-alexa-local node-red-contrib-amazon-echo node-red-contrib-alexa-notifyme node-red-contrib-heater-controller \
	node-red-contrib-find-my-iphone node-red-contrib-ttn node-red-contrib-apple-find-me node-red-contrib-msnodesql node-red-contrib-homekit-bridged node-red-contrib-homebridge-automation ; do
		printstatus "Installing node \"${addonnodes}\""
		npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	done
	
	if [[ $MYMENU == *"hwsupport"* ]]; then
	printstatus "Installing node \"i2c-bus\""
        npm $NQUIET install i2c-bus 2>&1 | tee -a $LOGFILE
	fi
	printstatus "Installing node \"bcryptjs\""
    sudo npm $NQUIET install bcryptjs 2>&1 | tee -a $LOGFILE

	if [[ $MYMENU == *"hwsupport"* ]]; then
		## this last bit of code is to ensure that node-red-contrib-opi-gpio can gain access to port bits!!
		getent group gpio || sudo groupadd gpio 2>&1 | tee -a $LOGFILE
		getent group gpio | grep -w -l pi || sudo adduser pi gpio 2>&1 | tee -a $LOGFILE
		[ ! -f /etc/udev/rules.d/99-com.rules ] && echo "KERNEL==\"gpio*\", RUN=\"/bin/sh -c 'chgrp -R gpio /sys/%p /sys/class/gpio && chmod -R g+w /sys/%p /sys/class/gpio'\"" | sudo tee -a /etc/udev/rules.d/99-com.rules > /dev/null
		
		if [[ $OPSYS == *"RASPBIAN"* ]]; then
			sudo sed -i -e 's#exit 0#chmod 777 /dev/ttyAMA0\nexit 0#g' /etc/rc.local
			sudo apt-get -y install python{,3}-rpi.gpio 2>&1 | tee -a $LOGFILE
		else
			if [[ $MYMENU == *"generich3"* ]]; then
				npm $NQUIET install node-red-contrib-opi-gpio 2>&1 | tee -a $LOGFILE
			fi
		fi
		sudo sed -i -e 's#exit 0#chmod 777 /dev/ttyS*\nexit 0#g' /etc/rc.local
	fi
            
	cd ~/.node-red/
    npm $NQUIET audit fix
	sudo wget -a $LOGFILE $AQUIET https://tech.scargill.net/iot/settings.txt -O settings.js

	echo " "
	bcryptadminpass=$(node -e "console.log(require('bcryptjs').hashSync(process.argv[1], 8));" $adminpass)
	bcryptuserpass=$(node -e "console.log(require('bcryptjs').hashSync(process.argv[1], 8));" $userpass)
	# echo Encrypted password: $bcryptpass
	cp settings.js settings.js.bak-pre-crypt

	sed -i -e "s#\/\/adminAuth#adminAuth#" /home/pi/.node-red/settings.js
	sed -i -e "s#\/\/httpNodeAuth#httpNodeAuth#" /home/pi/.node-red/settings.js
	sed -i -e "s#NRUSERNAMEA#$adminname#" /home/pi/.node-red/settings.js
	sed -i -e "s#NRPASSWORDA#$bcryptadminpass#" /home/pi/.node-red/settings.js
	sed -i -e "s#NRUSERNAMEU#$username#" /home/pi/.node-red/settings.js
	sed -i -e "s#NRPASSWORDU#$bcryptuserpass#" /home/pi/.node-red/settings.js
	if [[ $MYMENU == *"hwsupport"* ]]; then
	    sed -i -e "s#\/\/var i2c#var i2c#" /home/pi/.node-red/settings.js
	    sed -i -e "s#\/\/i2c#i2c#" /home/pi/.node-red/settings.js
	fi
    sudo systemctl enable nodered.service 2>&1 | tee -a $LOGFILE
    ## add a nice little command line utility (nrlog) for showing and tailing Node-Red scripts in colour
	echo "alias nrlog='sudo journalctl -f -n 50 -u nodered -o cat | ccze -A'" | sudo tee -a /etc/bash.bashrc > /dev/null 2>&1
fi

cd ~/.node-red
npm audit fix --force

cd ~

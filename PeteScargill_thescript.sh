##
## "The Script" is the product of years of work by me (Peter Scargill) and others, in particular Antonio Fragola (Mr Shark)
## Supports Raspberry Pi with Buster  - also other boards and op systems but since 2021 this
## script is only tested on Raspberry Pi (2,3,4) (Raspberry Pi OS, formerly Buster) (full or lite, not NOOBS). See below and if you
##try it on other systems with success, please let mne know.
##
## Makes use of the official Node-Red script (which I DIDN'T write) and my own Node-Red nodes such as BigTimer.
##
## To use my own exact setup you will also need: 
##  	sudo python -m pip install --upgrade pip setuptools wheel
##  	sudo pip install Adafruit-SSD1306
##  	my /home/pi/fonts directory (ProggyTiny.ttf) - and sample programs /home/pi/stats.py and 
##  	stats32.py - this lot for people who want to run ssd1306 displays (32 or 64 px high) 
## 		in Python rather than installing i2c support in Node-Red
##
## Includes:
##  	Mosquitto (port 1883) with web sockets (Port 9001)
##  	SQLITE ( xxx.xxx.xxx.xxx/phpliteadmin),
##  	Node-Red (xxx.xxx.xxx:1880)
##  	Node-Red-Dashboard (xxx.xxx.xxx.xxx:1880/ui)
##  	Webmin (xxx.xxx.xxx:10000)
##  	Apache (xxx.xxx.xxx) (recommend replacing using nginx)
##  	mpg123
##  	Grafana (xxx.xxx.xxx:3000) - defaults to password "password" and offers to let you change it.
## 		Web-page-based software like mc, micro and phpsysinfo.	
##
## IMPORTANT:-
## 1. Run initially ONLY as user PI on Raspberry Pi (or ROOT on other hardware). If ROOT, PI user will be checked/created for you as the main
##    script must be run as pi.
##    User PI must be in the SUDO group (automatic on Raspberry Pi). Other groups are added if needed by the script.
## 2. When selecting GPIO for non-Raspberry Pi devices note - specific support for ODROID C2 only
## 3. Steer away from midnight to avoid any updates such as dietpi upgrades etc.
##    Recommend NOT using this on Pi Zero as it will be VERY slow.
## 4. For non-Raspberry Pi systems, when asked by Armbian to make a new user - don't bother - the script will do it.
## 5. Do not access this script as SUDO.
##
## INSTALLATION:-
## 	The easiest way to get the script on your machine is:
## 	wget --no-check-certificate  https://bitbucket.org/api/2.0/snippets/scargill/kAR5qG/master/files/script.sh
## 	as described here: https://tech.scargill.net/the-script
##
## For Log2RAM customising see this - https://github.com/azlux/log2ram
##
## See https://tech.scargill.net/orange-pi-pc-battle-of-the-pis/
##
## We cannot answer questions on board/operating system combinations we have not tested. See notes below for tested combos and dates.
## 
## 01/08/2021   It seems for nwo there's an issue of influxdb no longer being available for RPi (32 bit). While we're working on that I  suggest NOT installing Grafana from the script.
## 20/06/2020 - RPi added more useful NR contrib nodes
## 08/06/2020 - Changed the version of the Node-Red script as NR have made a change
## 24/05/2020 - Fix for extra tabs on PI Cockpit addition - thanks to Dominic
## 23/05/2020 - added cockpit as option in RPI
## 16/05/2020 - note at this time the "micro" editor still has cut and paste issues - consider grabbing the latest nightly build and overwriting the /home/pi/micro file
##  Example only:
##   wget  https://github.com/zyedidia/micro/releases/download/nightly/micro-2.0.4-dev.19-linux-arm.tar.gz
##   tar -zxvf micro-2.0.4-dev.19-linux-arm.tar.gz
##   copy the micro file from the new micro... folder to /home/pi then delete the tar.gz file and the new micro... folder
##
## 16/05/2020 added Nginx as an alternative to Apache as a webserver, ONLY tested on Raspbian and Debian BUSTER!
## 14/05/2020 added in the MICRO editor (not the nightly),
## 	removed ha-bridge as it no longer works and there are other ways to control Alexa today
## 11/05/2020 changed reference to http://tech.scargill.net to the https version, 
## 	improved remote root access and fixed/improved basic web page, removed DarkSky node
## 19/12/2019 fixed a connection check.
## 	Previous updates includes changes to handle Raspbian Buster, RPi4 and other recent changes
##  including the latest Node/Node-Red updates (at this time v1.0.2) on Raspbian 
##  and to use official NR install script on RPi - also fixes to accomodate changed Grafana Repository. 
##  NetTools added, Glances and Bottle commented out due to issues with their scripting.
##  Also got rid of NPM warnings
## 25/10/2019 Installed all defaults in the script and in addition non-default Grafana onto an ACEPC T9 on which I'd installed the latest Debian Buster
## 	Note that Buster on a non-Pi machine may not have SUDO installed by default. To become a super-user to install it if you can't get to root, "su -".
## 01/07/2019 used 3-liner as in the blog to upgrade an RPI which had been set up initially using the script in Stretch - to Buster.
## 17/02/2019 Added pure-ftp
## 07/02/2019 Separated NR into official NR install script, added tcpdump - not added fing but worth doing?
## 17/02/2019 I added nmap, netdiscover and also node-red-contrib-advanced-ping
## 20/08/2018 Fixed Java and settings.js generation, added menu option (default: UNCHECKED) to enable/disable Pi HW support (I2C, GPIO, Serial, etc)
## 01/05/2018 InfluxDB/Grafana/Chronograf install, now works on every platform tested, and succesfully tested on Rock64+eMMc
## 05/10/2017 Added glances - use directly - glances - or as webserver glances -w
## 08/09/2017 Added name change for Node-Red flows files to generic
## 31/08/2017 Scrapped JED as MC is much better - added rpi-clone which works a treat with NANOPI - indispensible on Raspberry Pi.
## 30/08/2017 Changed Webmin to NOT be installed by default
## 24/08/2017 Tested Ubuntu on Odroid C2 and Roseapple Pi 
## 23/08/2017 Tested on the NanoPi K2 board running Ubuntu, installs perfectly (but note that
##            FriendlyArm's WiringPi i2c is currently bust)
## 18/08/2017 Modified to handle latest Raspbian Stretch - tested on RPI3
## 10/08/2017 Added "nrlog" utility for viewing and "tailing" - i.e. monitoring node-red logs in colour in
## 	a terminal
## 10/08/2017 Tested RPI3 - turns out the new GPIO nodes work perfectly on that - as does i2c
## 	- commenting out the RPI contrib GPIO as it needs ROOT permissions!!!!!
## 	see https://tech.scargill.net/the-real-raspberry-pi/
## 29/07/2017 Added rule to help node-red-contrib-opi-gpio utility with various boards using GPIO. See docs
## 	for that node - very promising - tried various nano boards with success
## 24/07/2017 Tested on the new NanoPi Neo Plus2 - worked a treat - I2c running - lovely
## 24/07/2017 Tested on a Raspberry Pi 2 using current Jessie
## 24/07/2017 Tested NanoPi Neo Air using Ubuntu Core Xenial 4.11.2
## 30/06/2017 added LOG FILE generation, same folder and name as script + datetime + .log - by MrShark
## 26/06/2017 added support for Debian 9 (Stretch), right now only tested in VM - by MrShark
## 26/04/2017 added option for Log2Ram
## 26/04/2017 Updated NodeJS as they took the previous version off the server!!!
## 29/03/2017 Tested on NanoPi Neo2 using Armbian nightly build of 27/03/2017 - added temperature and processor checks
## 25/03/2017 Tested on NanoPi M1+, host updating added and defaults on inputs added
## 18/03/2017 Tested on NanoPi M3
## 16/03/2017 Modifications to handle experimental Android Phone setup
## 10/03/2017 Modifications to detect and run with the Raspberry Pi Zero Lite (ARM6) (not recommended, Zero is very slow)
## 30/01/2017 Minor change to let the script work on Mint Linux on a laptop (Looks like Ubuntu)
## 14/01/2017 Updated webmin and habridge installations
## 04/07/2017 OrangePi Plus 2 - thanks to blog reader RoyG for that
## 26/12/2016 - complete re-hash for new menus
## 02/12/2016 Tested Roseapple Pi using Armbian - for Node-Red serial, had to
## 	enable permissions for the serial - everything worked first time
## 16/05/2016  Tested on NanoPi M1 - (got 3 UARTS out of the M1)

## 22/06/2016 tested on NanoPi NEO using Armbian Jessie Server
## 28/12/2016 tested in DietPi and Xenial virtual machines
## 	http://www.armbian.com/donate/?f=Armbian_5.20_Nanopineo_Debian_jessie_3.4.112.7z
##
## NOTE:- removed node-red-contrib-admin from Node-red setup as you can now do installs in the palette manager 
## within the editor
## Note also  - the PHONE setting is experimental assuming an Android phone, rooted and set up with "Linux Deploy"
## as per the relevant blog entry on https://tech.scargill.net
##
## Typically, sitting in your home directory (/home/pi) as user Pi you might want to use NANO editor  to install this script
## and after giving the script execute permission (sudo chmod 0744 /home/pi/script.sh)
## you could run the file as ./script.sh
##
##
## Note:- on the Odroid C2, everything installed except Webmin. After reboot this is what I did to get it running..
##    wget http://prdownloads.sourceforge.net/webadmin/webmin_1.850_all.deb
##    sudo dpkg --install webmin_1.850_all.deb
##    That complained about missing bits so I used...
##       sudo apt-get install -y perl libnet-ssleay-perl openssl libauthen-pam-perl
##       libpam-runtime libio-pty-perl apt-show-versions python
##    That seemed to fail and suggested I use...
##       sudo apt-get -y -f install
##    That installed the lot - working - something to do with it being 64 bits - but it works -
##    pi or root user and password and https://whatever:10000
##
## Node-Red security added as standard - using the ADMIN login. MQTT also has same ADMIN login.
##

# Get time as a UNIX timestamp (seconds elapsed since Jan 1, 1970 0:00 UTC)
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


############################################################################
##
## MAIN SECTION OF SCRIPT - action begins here
##
#############################################################################
##

printstatus "Welcome to 'The Script'"

AQUIET="-qq"
NQUIET="-s"
export npm_config_loglevel=silent

# install sudo on devices without it
[ ! -x /usr/bin/sudo ] && apt-get $AQUIET -y update > /dev/null 2>&1 && apt-get $AQUIET -y install sudo 2>&1 | tee -a $LOGFILE

# Whiptail menu may already be installed by default, on the other hand maybe not.
sudo apt-get $AQUIET -y install whiptail ccze net-tools 2>&1 | tee -a $LOGFILE
# Another way - Xenial should come up in upper case in $DISTRO
. /etc/os-release
OPSYS=${ID^^}
echo -e OPSYS: $OPSYS >> $LOGFILE

printstatus "Grabbing some preliminaries..."

# test internet connection
sudo chmod u+s /bin/ping
if [[ "$(ping -c 1 8.8.8.8  | grep '100%' )" != "" ]]; then
    printl "${IRed}!!!! No internet connection available, aborting! ${IWhite}\r\n"
    exit 0
fi

# install lsb_release on devices without it
[ ! -x /usr/bin/lsb_release ] && apt-get $AQUIET -y update > /dev/null 2>&1 && apt-get $AQUIET -y install lsb-release 2>&1 | tee -a $LOGFILE
DISTRO=$(/usr/bin/lsb_release -rs)
CHECK64=$(uname -m)
echo -e DISTRO: $DISTRO >> $LOGFILE
echo -e CHECK64: $CHECK64 >> $LOGFILE

if [[ $OPSYS == *"UBUNTU"* ]]; then
    if [ $DISTRO != "16.04" ] ; then
        printl "${IRed}!!!! Wrong version of Ubuntu - not 16.04, aborting! ${IWhite}\r\n"
        exit 0
    fi
fi

# user pi existence/creation for non-Raspberry Pi hardware
echo -e USER: $USER >> $LOGFILE
if [[ $USER != "pi" ]]; then
    if [[ $USER == "root" ]]; then
        printf "\r\n${ICyan}Hello ROOT... ${IWhite}"
        getent passwd pi > /dev/null 2>&1
        if [ $? -eq 0 ]; then
            printf "${ICyan}user \"pi\" exists, please log-out as root and run script as pi.${IWhite}\r\n\r\n"
            usermod pi -g sudo -G ssh -a
            echo "pi ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/pi
            chmod 0440 /etc/sudoers.d/pi
            chmod 4755 /usr/bin/sudo			
            cp $(readlink -f $0) /home/pi && chown pi.pi /home/pi/$0 && chmod 755 /home/pi/$0
            chown pi.pi $LOGFILE && chmod 644 $LOGFILE && cp $LOGFILE /home/pi
        else
            adduser --quiet --disabled-password --shell /bin/bash --home /home/pi --gecos "User" pi
            echo "pi:password" | chpasswd
            usermod pi -g sudo -G ssh -a
            echo "pi ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/pi
            chmod 0440 /etc/sudoers.d/pi
            chmod 4755 /usr/bin/sudo
            printf "${ICyan}user PI created, password is \"password\". Please log-out as root and login as pi, and redo the procedure ${IWhite}\r\n\r\n"
            cp $(readlink -f $0) /home/pi && chown pi.pi /home/pi/$0 && chmod 755 /home/pi/$0
            chown pi.pi $LOGFILE && chmod 644 $LOGFILE && cp $LOGFILE /home/pi
        fi
        exit
    else
        printstatus "Leaving script as you are neither PI nor ROOT user."
        exit
    fi
else
	if [[ $OPSYS != *"RASPBIAN"* ]]; then
		sudo touch /etc/AlreadyRun
	fi
fi

if [ ! -f /etc/AlreadyRun ]; then
	printstatus "Stopping IPV6 access"
	echo "net.ipv6.conf.all.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf > /dev/null 2>&1
	echo "net.ipv6.conf.default.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf > /dev/null 2>&1
	echo "net.ipv6.conf.lo.disable_ipv6 = 1" | sudo tee -a /etc/sysctl.conf > /dev/null 2>&1
	sudo sysctl -p

	printstatus "Allow remote root login and speed up SSH"
	sudo sed -i -e 's/#PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
	sudo sed -i -e 's/#PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
	sudo sed -i -e 's/#PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
	sudo sed -i -e 's/PermitRootLogin no/PermitRootLogin yes/g' /etc/ssh/sshd_config
	sudo sed -i -e 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
	sudo sed -i -e 's/PermitRootLogin prohibit-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
	sudo sed -i -e 's/TCPKeepAlive yes/TCPKeepAlive no/g' /etc/ssh/sshd_config
	sudo sed -i '$ a UseDNS no' /etc/ssh/sshd_config
	sudo sed -i '$ a ClientAliveInterval 30' /etc/ssh/sshd_config
	sudo sed -i '$ a ClientAliveCountMax 100' /etc/ssh/sshd_config
	sudo /etc/init.d/ssh restart 2>&1 | tee -a $LOGFILE

	sudo update-alternatives --set newt-palette /etc/newt/palette.original 2>&1 | tee -a $LOGFILE

	# setup a progress bar
	echo "Dpkg::Progress-Fancy \"1\";" | sudo tee /etc/apt/apt.conf.d/99progressbar > /dev/null
	echo "APT::Color \"1\";" | sudo tee -a /etc/apt/apt.conf.d/99progressbar > /dev/null
	
	if [[ $OPSYS != *"RASPBIAN"* ]]; then
		printstatus "Adding user Pi permissions"
		for additionalgroup in cdrom games users i2c adm gpio input sudo netdev audio video dialout plugdev bluetooth ; do
			getent group ${additionalgroup} | grep -w -l pi || sudo adduser pi ${additionalgroup} 2>&1 | tee -a $LOGFILE
		done
	fi
    sudo apt-get install avahi-daemon avahi-utils -y 2>&1 | tee -a $LOGFILE
    sudo sed -i -e 's/use-ipv6=yes/use-ipv6=no/g' /etc/avahi/avahi-daemon.conf
else
        printstatus "'The Script' is re-running, avoiding un-necessary repeats"
fi

if [[ $OPSYS == "LINUXMINT" ]]; then
    OPSYS="UBUNTU"
fi

if [[ $OPSYS != *"RASPBIAN"* ]] && [[ $OPSYS != *"DEBIAN"* ]] && [[ $OPSYS != *"UBUNTU"* ]] && [[ $OPSYS != *"DIETPI"* ]]; then
    printl "${BIRed}By the look of it, not one of the supported operating systems - aborting${BIWhite}\r\n"; exit
fi

username="user"
userpass="password123"

adminname="admin"
adminpass="password123"

newhostname=$(hostname)

SECONDS=0

if [[ $OPSYS == *"RASPBIAN"* ]];then
    MYMENU=$(whiptail --title "Peter Scargill's 'The Script' Main Menu for Raspberry Pi" --checklist \
        "\n   Make your selections (SPACE) as required then TAB to OK/Cancel" 29 73 20 \
        "quiet" "Quiet(er) install - untick for lots of info " ON \
        "prereq" "Install general pre-requisites " ON \
        "mosquitto" "Install Mosquitto" ON \
        "apache" "Install Apache/PHP/SQLITE + PHPLITEADMIN " OFF \
        "nginx" "Install Nginx/PHP/SQLITE + PHPLITEADMIN " ON \
        "nodenew" "Install NodeJS and NodeRed (Raspberry Pi)" ON \
        "webmin" "Install Webmin" OFF \
        "java" "Update Java" OFF \
        "hwsupport" "Enable support for Serial, I2C, GPIO, etc" OFF \
        "wiringpi" "Wiring Pi for the GPIO utility" OFF \
        "phpsysinfo" "Install PHPSYSYINFO" ON \
        "modpass" "Mod USER and ADMIN passwords (password123)" ON \
        "addindex" "Add a basic index page and CSS" ON \
        "passwords" "Update ROOT and PI user passwords" OFF \
        "rpiclone" "Install RPI-Clone" ON \
        "log2ram" "Install Log2RAM default 40 Meg" OFF \
		"grafana" "Install Grafana and InfluxDB" OFF \
		"cockpit" "Install Cockpit" ON \
 		"wolfram" "Remove Wolfram on a PI to save space" OFF \
        "office" "Remove LibreOffice on PI to save space" OFF 3>&1 1>&2 2>&3)
else
    MYMENU=$(whiptail --title "Peter Scargill's 'The Script' Main Non-Pi Menu" --checklist \
        "\n   Make your selections (SPACE) as required then TAB to OK/Cancel" 29 73 21 \
        "quiet" "Quiet(er) install - untick for lots of info " ON \
        "prereq" "Install general pre-requisites" ON \
        "mosquitto" "Install Mosquitto" ON \
        "apache" "Install Apache/PHP/SQLITE + PHPLITEADMIN" ON \
        "nginx" "Install Nginx/PHP/SQLITE + PHPLITEADMIN " OFF \
        "nodenew" "Install NodeJS and NodeRed (NEW)" ON \
        "nodejs" "Install NodeJS" OFF \
        "nodered" "Install Node-Red" OFF \
        "webmin" "Install Webmin" OFF \
        "java" "Update Java" OFF \
        "hwsupport" "Enable support for Serial, I2C, GPIO, etc" OFF \
        "phone" "Install on Android Smartphone - see blog" OFF \
        "odroid" "Install ODROID C2-specific GPIO" OFF \
        "generich3" "Install GENERIC H3 GPIO (not Raspberry Pi) " OFF \
        "phpsysinfo" "Install PHPSYSYINFO" ON \
        "modpass" "Mod USER and ADMIN passwords (password123)" ON \
        "addindex" "Add an index page and some CSS" ON \
        "passwords" "Update ROOT and PI user passwords" OFF \
        "rpiclone" "Install RPI-Clone" ON \
        "log2ram" "Install Log2RAM default 40Meg" OFF \
		"grafana" "Install Grafana and InfluxDB" OFF 3>&1 1>&2 2>&3)
fi

if [[ $MYMENU != *"quiet"* ]]; then
    AQUIET=""
    NQUIET=""
	unset npm_config_loglevel
fi

if [[ $MYMENU == "" ]]; then
    whiptail --title "Installation Aborted" --msgbox "Cancelled as requested." 8 78
    exit
fi

cd
newhostname=$(whiptail --inputbox "Enter new HOST name\nLeave the default value or select something new" 8 60 $newhostname 3>&1 1>&2 2>&3)

if [[ $MYMENU == *"modpass"* ]]; then
    
    username=$(whiptail --inputbox "Enter a USER name (example user)\nSpecifically for Node-Red Dashboard" 8 60 $username 3>&1 1>&2 2>&3)
    if [[ -z "${username// }" ]]; then
        printf "No user name given - aborting\r\n"; exit
    fi
    
    userpass=$(whiptail --passwordbox "Enter a user password" 8 60 3>&1 1>&2 2>&3)
    if [[ -z "${userpass// }" ]]; then
        printf "No user password given - aborting${BIWhite}\r\n"; exit
    fi
    
    userpass2=$(whiptail --passwordbox "Confirm user password" 8 60 3>&1 1>&2 2>&3)
    if  [ $userpass2 == "" ]; then
        printf "${BIRed}No password confirmation given - aborting${BIWhite}\r\n"; exit
    fi
    if  [ $userpass != $userpass2 ]
    then
        printf "${BIRed}Passwords don't match - aborting${BIWhite}\r\n"; exit
    fi
    
    adminname=$(whiptail --inputbox "Enter an ADMIN name (example admin)\nFor Node-Red and MQTT" 8 60 $adminname 3>&1 1>&2 2>&3)
    if [[ -z "${adminname// }" ]]; then
        printf "${BIRed}No admin name given - aborting${BIWhite}\r\n"
        exit
    fi
    
    adminpass=$(whiptail --passwordbox "Enter an admin password" 8 60 3>&1 1>&2 2>&3)
    if [[ -z "${adminpass// }" ]]; then
        printf "${BIRed}No user password given - aborting${BIWhite}\r\n"; exit
    fi
    
    adminpass2=$(whiptail --passwordbox "Confirm admin password" 8 60 3>&1 1>&2 2>&3)
    if  [ $adminpass2 == "" ]; then
        printf "${BIRed}No password confirmation given - aborting${BIWhite}\r\n"; exit
    fi
    if  [ $adminpass != $adminpass2 ]; then
        printf "${BIRed}Passwords don't match - aborting${BIWhite}\r\n"; exit
    fi
fi

if [[ $MYMENU == *"passwords"* ]]; then
    echo "Update your PI password"
    sudo passwd pi
    echo "Update your ROOT password"
    sudo passwd root
fi

if [[ $MYMENU == *"phone"* ]]; then
    echo "en_US.UTF-8 UTF-8" | sudo tee -a /etc/locale.gen > /dev/null
    # echo "service rsyslog stop" | sudo tee -a /etc/init.d/rc.local > /dev/null
    sudo update-rc.d rsyslog disable 2>&1 | tee -a $LOGFILE
    sudo locale-gen 2>&1 | tee -a $LOGFILE
    sudo sed -i -e 's#exit 0##g' /etc/rc.local
  #  ha-bridge used to be here
    echo "exit 0" | sudo tee -a /etc/rc.local > /dev/null
fi

if [[ $MYMENU == *"cockpit"* ]]; then
    printstatus "Adding Cockpit"
	sudo apt-get update
	sudo apt install $AQUIET -y --fix-missing cockpit 2>&1 | tee -a $LOGFILE
	sudo systemctl enable cockpit.socket	
fi

if [[ $MYMENU == *"wolfram"* ]]; then
    printstatus "Removing Wolfram"
    sudo apt-get $AQUIET -y purge wolfram-engine 2>&1 | tee -a $LOGFILE
fi

if [[ $MYMENU == *"office"* ]]; then
    printstatus "Removing LibreOffice"
    sudo apt-get $AQUIET -y remove --purge libreoffice* 2>&1 | tee -a $LOGFILE
fi

if [[ $MYMENU == *"prereq"* ]]; then
    printstatus "Installing pre-requisites (this could take some time)"
    sudo apt-get $AQUIET -y autoremove 2>&1 | tee -a $LOGFILE
    sudo apt-get $AQUIET  update 2>&1 | tee -a $LOGFILE
    sudo apt-get $AQUIET -y upgrade 2>&1 | tee -a $LOGFILE
    # fix for RPI treating PING as a root function - by Dave
    sudo setcap cap_net_raw=ep /bin/ping > /dev/null 2>&1
    sudo setcap cap_net_raw=ep /bin/ping6 > /dev/null 2>&1
    # Prerequisite suggested by Julian and adding in python-dev - and stuff I've added for SAMBA and telnet, and Common utilities

    sudo apt-get install $AQUIET -y apt-utils 2>&1 | tee -a $LOGFILE # a line on its own, as on some boards caused problems on next one...
	sudo apt-get install $AQUIET -y nmap netdiscover sysfsutils tcpdump pure-ftpd wget ssh bash-completion unzip build-essential git python-serial scons libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libsqlite3-dev subversion libcurl4-openssl-dev libusb-dev python-dev cmake curl telnet usbutils gawk jq pv samba samba-common samba-common-bin winbind dosfstools parted gcc python-pip htop python-smbus mc cu mpg123 screen 2>&1 | tee -a $LOGFILE
	sudo pip -q install psutil 2>&1 | tee -a $LOGFILE
	sudo -H pip -q install feedparser 2>&1 | tee -a $LOGFILE
    # This line to ensure name is resolved from hosts FIRST
    sudo sed -i '/\[global\]/a name resolve order = hosts wins bcast' /etc/samba/smb.conf
	
	if [[ $MYMENU == *"hwsupport"* ]]; then
		sudo apt-get install $AQUIET -y i2c-tools 2>&1 | tee -a $LOGFILE
	fi
fi

if [[ $MYMENU == *"mosquitto"* ]]; then
    printstatus "Installing Mosquitto with Websockets"
    cd
    if [[ $OPSYS == *"UBUNTU"* ]]; then
        sudo apt-get $AQUIET -y install mosquitto mosquitto-clients 2>&1 | tee -a $LOGFILE
        [ $? -eq 0 ] && mosquitto=1 # mosquitto installed
    else
		if [[ $OPSYS == *"BIAN"* ]] && [[ $DISTRO == *"8."* ]]; then
			wget http://repo.mosquitto.org/debian/mosquitto-repo.gpg.key -a $LOGFILE -O - | sudo apt-key add -
			echo "deb http://repo.mosquitto.org/debian jessie main" |sudo tee /etc/apt/sources.list.d/mosquitto-jessie.list
		fi
		sudo apt-get $AQUIET -y update && sudo apt-get $AQUIET -y install mosquitto mosquitto-clients 2>&1 | tee -a $LOGFILE
		[ $? -eq 0 ] && mosquitto=1 # mosquitto installed
    fi
    # add mosquitto mods+pass ONLY if it was installed...
    if [ $mosquitto -eq 1 ]; then
        sudo bash -c "echo -e \"listener 9001\nprotocol websockets\nlistener 1883\nallow_anonymous false\npassword_file /etc/mosquitto/passwords\" > /etc/mosquitto/conf.d/websockets.conf"
        sudo touch /etc/mosquitto/passwords
        sudo mosquitto_passwd  -b /etc/mosquitto/passwords $adminname $adminpass
        if [[ $OPSYS == *"RASPBIAN"* ]]; then
			echo -e "[Unit]\n\
Description=Mosquitto MQTT Broker daemon\n\
ConditionPathExists=/etc/mosquitto/mosquitto.conf\n\
After=network.target\n\
Requires=network.target\n\
\n\
[Service]\n\
Type=forking\n\
RemainAfterExit=no\n\
StartLimitInterval=0\n\
PIDFile=/var/run/mosquitto.pid\n\
ExecStart=/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf -d\n\
ExecReload=/bin/kill -HUP $MAINPID\n\
Restart=on-failure\n\
RestartSec=2\n\
\n\
[Install]\n\
WantedBy=multi-user.target\n" | sudo tee /lib/systemd/system/mosquitto
			sudo systemctl  start mosquitto 2>&1 | tee -a $LOGFILE
			sudo systemctl enable mosquitto 2>&1 | tee -a $LOGFILE
		fi
	echo "alias mqttlog='tail -f /var/log/mosquitto/mosquitto.log | ccze -A'" | sudo tee -a /etc/bash.bashrc > /dev/null 2>&1
    else
        printl "${IRed}!!!! Mosquitto not installed! ${IWhite}\r\n"
    fi
fi

if [[ $MYMENU == *"wiringpi"* ]]; then
    printstatus "Installing WiringPi"
	cd
	wget  --no-check-certificate https://project-downloads.drogon.net/wiringpi-latest.deb -a $LOGFILE
    if [ $? -eq 0 ]; then
		sudo dpkg -i wiringpi-latest.deb
    else
        printl "${IRed}!!!! Wiringpi not installed! ${IWhite}\r\n"
    fi 
fi

# Moved sqlite3 so that node-red sql node will install
# use back facing quotes in here - no idea why.
# Changed the order of installation of Apache etc to solve issues with ARMBIAN
#

if [[ $MYMENU == *"apache"* ]] || [[ $MYMENU == *"nginx"* ]]; then
    cd
    sudo groupadd -f -g33 www-data
    if [[ $MYMENU == *"apache"* ]]; then
	    printstatus "Installing Apache/PHP and Sqlite"
		if [[ $OPSYS != *"UBUNTU"* ]]; then
			if [[ $OPSYS == *"BIAN"* ]] && [[ $DISTRO == *"10"* ]]; then
				sudo apt-get $AQUIET -y install apache2 libapache2-mod-php7.3 sqlite3 php-sqlite3 php-xml php-mbstring 2>&1 | tee -a $LOGFILE
			fi
			if [[ $OPSYS == *"BIAN"* ]] && [[ $DISTRO == *"9."* ]]; then
				sudo apt-get $AQUIET -y install apache2 libapache2-mod-php7.0 sqlite3 php-sqlite3 php-xml php-mbstring 2>&1 | tee -a $LOGFILE
			fi
			if [[ $OPSYS == *"BIAN"* ]] && [[ $DISTRO == *"8"* ]]; then
				sudo apt-get $AQUIET -y install apache2 libapache2-mod-php5 sqlite3 php5-sqlite 2>&1 | tee -a $LOGFILE
			fi
			[ $? -eq 0 ] && webserver=1 # apache installed
		else
			sudo apt-get $AQUIET -y install apache2 libapache2-mod-php7.0 sqlite3 php-sqlite3 php-xml php-mbstring 2>&1 | tee -a $LOGFILE
			[ $? -eq 0 ] && webserver=1 # apache installed
		fi
	fi
	if [[ $MYMENU == *"nginx"* ]]; then
	    printstatus "Installing NGINX/PHP and Sqlite"
		if [[ $OPSYS == *"BIAN"* ]] && [[ $DISTRO == *"10"* ]]; then
			sudo apt-get $AQUIET -y remove --purge *apache* *php* 2>&1 | tee -a $LOGFILE
			sudo apt-get $AQUIET -y autoremove 2>&1 | tee -a $LOGFILE
			sudo apt-get $AQUIET -y install nginx sqlite3 php php7.3-{common,cli,fpm,json,zip,gd,mbstring,curl,xml,bcmath,sqlite3} php-pear 2>&1 | tee -a $LOGFILE
			[ $? -eq 0 ] && webserver=1 # nginx installed
			sudo cp /etc/nginx/sites-available/default /etc/nginx/sites-available/default.bak
			sudo sed -i -e 's/index index.html/index index.php index.html/g' /etc/nginx/sites-enabled/default
			sudo sed -i -e 's/#location ~ \\.php$ {/location ~ \\.php$ {/g' /etc/nginx/sites-enabled/default
			sudo sed -i -e 's/#.*include snippets\/fastcgi/        include snippets\/fastcgi/g' /etc/nginx/sites-enabled/default
			sudo sed -i -e 's/#.*fastcgi_pass unix/        fastcgi_pass unix/g' /etc/nginx/sites-enabled/default
			sudo sed -i -e '63s/#}/}/' /etc/nginx/sites-enabled/default
			#sudo nginx -t
			#sudo systemctl restart nginx php7.3-fpm
		fi
	fi
    # if apache OR nginx installed and /var/www/html exists, go on...
    if [ $webserver -eq 1 ] && [ -d /var/www/html ]; then
        cd /var/www/html
        sudo mkdir phpliteadmin
        cd phpliteadmin
        #sudo wget --no-check-certificate http://bitbucket.org/phpliteadmin/public/downloads/phpLiteAdmin_v1-9-7-1.zip -a $LOGFILE
        sudo wget --no-check-certificate https://www.phpliteadmin.org/phpliteadmin-dev.zip -a $LOGFILE
        if [ $? -eq 0 ]; then
            sudo unzip phpliteadmin-dev.zip 2>&1 | tee -a $LOGFILE
            sudo mv phpliteadmin.php index.php
            sudo mv phpliteadmin.config.sample.php phpliteadmin.config.php
            sudo rm *.zip
            sudo mkdir themes
            cd themes
            sudo wget --no-check-certificate http://bitbucket.org/phpliteadmin/public/downloads/phpliteadmin_themes_2016-02-29.zip -a $LOGFILE
            sudo unzip phpliteadmin_themes_2016-02-29.zip 2>&1 | tee -a $LOGFILE
            sudo rm *.zip
            sudo sed -i -e 's#\$directory = \x27.\x27;#\$directory = \x27/home/pi/dbs/\x27;#g' /var/www/html/phpliteadmin/phpliteadmin.config.php
            sudo sed -i -e "s#\$password = \x27admin\x27;#\$password = \x27$adminpass\x27;#g" /var/www/html/phpliteadmin/phpliteadmin.config.php
            sudo sed -i -e "s#\$subdirectories = false;#\$subdirectories = true;#g" /var/www/html/phpliteadmin/phpliteadmin.config.php
            cd
        else
            printl "${IRed}!!!! PHPLITEADMIN not installed! ${IWhite}\r\n"
            cd ; rm -rf /var/www/html/phpliteadmin
        fi
        
        mkdir dbs
		sqlite3 /home/pi/dbs/iot.db << EOF
		CREATE TABLE IF NOT EXISTS \`pinDescription\` (
		 \`pinID\` INTEGER PRIMARY KEY NOT NULL,
		 \`pinNumber\` varchar(2) NOT NULL,
		 \`pinDescription\` varchar(255) NOT NULL
		);
		CREATE TABLE IF NOT EXISTS \`pinDirection\` (
		 \`pinID\` INTEGER PRIMARY KEY NOT NULL,
		 \`pinNumber\` varchar(2) NOT NULL,
		 \`pinDirection\` varchar(3) NOT NULL
		);
		CREATE TABLE IF NOT EXISTS \`pinStatus\` (
		 \`pinID\` INTEGER PRIMARY KEY NOT NULL,
		 \`pinNumber\` varchar(2)  NOT NULL,
		 \`pinStatus\` varchar(1) NOT NULL
		);
		CREATE TABLE IF NOT EXISTS \`users\` (
		 \`userID\` INTEGER PRIMARY KEY NOT NULL,
		 \`username\` varchar(28) NOT NULL,
		 \`password\` varchar(64) NOT NULL,
		 \`salt\` varchar(8) NOT NULL
		);
		CREATE TABLE IF NOT EXISTS \`device_list\` (
		 \`device_name\` varchar(80) NOT NULL DEFAULT '',
		 \`device_description\` varchar(80) DEFAULT NULL,
		 \`device_attribute\` varchar(80) DEFAULT NULL,
		 \`logins\` int(11) DEFAULT NULL,
		 \`creation_date\` datetime DEFAULT NULL,
		 \`last_update\` datetime DEFAULT NULL,
		 PRIMARY KEY (\`device_name\`)
		);

		CREATE TABLE IF NOT EXISTS \`readings\` (
		 \`recnum\` INTEGER PRIMARY KEY,
		 \`location\` varchar(20),
		 \`value\` int(11) NOT NULL,
		 \`logged\` timestamp not NULL DEFAULT CURRENT_TIMESTAMP ,
		 \`device_name\` varchar(40) not null,
		 \`topic\` varchar(40) not null
		);


		CREATE TABLE IF NOT EXISTS \`pins\` (
		 \`gpio0\` int(11) NOT NULL DEFAULT '0',
		 \`gpio1\` int(11) NOT NULL DEFAULT '0',
		 \`gpio2\` int(11) NOT NULL DEFAULT '0',
		 \`gpio3\` int(11) NOT NULL DEFAULT '0'
		);
		INSERT INTO PINS VALUES(0,0,0,0);
		CREATE TABLE IF NOT EXISTS \`temperature_record\` (
		 \`device_name\` varchar(64) NOT NULL,
		 \`rec_num\` INTEGER PRIMARY KEY,
		 \`temperature\` float NOT NULL,
		 \`date_time\` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
		);
		CREATE TABLE IF NOT EXISTS \`Device\` (
		 \`DeviceID\` INTEGER PRIMARY KEY,
		 \`DeviceName\` TEXT NOT NULL
		);
		CREATE TABLE IF NOT EXISTS \`DeviceData\` (
		 \`DataID\` INTEGER PRIMARY KEY,
		DeviceID INTEGER,
		 \`DataName\` TEXT, FOREIGN KEY(DeviceID ) REFERENCES Device(DeviceID)
		);
		CREATE TABLE IF NOT EXISTS \`Data\` (
		SequenceID INTEGER PRIMARY KEY,
		 \`DeviceID\` INTEGER NOT NULL,
		 \`DataID\` INTEGER NOT NULL,
		 \`DataValue\` NUMERIC NOT NULL,
		 \`epoch\` NUMERIC NOT NULL,
		 \`timestamp\` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP , FOREIGN KEY(DataID, DeviceID ) REFERENCES DeviceData(DAtaID, DeviceID )
		);
EOF
        
        cd
        chmod 777 /home/pi/dbs
        chmod 666 /home/pi/dbs/iot.db
        cd
    else
        printl "${IRed}!!!! Webserver+PHP+SQLITE+PHPLITEADMIN NOT INSTALLED! ${IWhite}\r\n"
    fi
fi

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
# TAKEN OUT  node-red-contrib-graphs - I dont use it, most likely defunct - no work done on it in 3 years
	for addonnodes in moment node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer \
	node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms \
	node-red-node-geofence node-red-contrib-moment node-red-contrib-particle \
	node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb \
	node-red-contrib-home-assistant-websocket node-red-contrib-ibm-watson-iot node-red-contrib-sun-position \
	node-red-contrib-tuya-local node-red-contrib-ui-led node-red-contrib-yr node-red-contrib-aedes \
	node-red-contrib-isonline node-red-node-ping node-red-node-random node-red-node-smooth node-red-contrib-npm node-red-node-arduino \
	node-red-contrib-file-function node-red-contrib-boolean-logic node-red-contrib-blynk-ws node-red-contrib-telegrambot node-red-contrib-dsm node-red-contrib-ftp \
	node-red-dashboard node-red-contrib-owntracks node-red-contrib-alexa-local node-red-contrib-amazon-echo node-red-contrib-alexa-notifyme node-red-contrib-heater-controller ; do
		printstatus "Installing node \"${addonnodes}\""
		npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	done
	
	printstatus "Installing node \"node-red-node-sqlite\""
	npm $NQUIET install --unsafe-perm node-red-node-sqlite 2>&1 | tee -a $LOGFILE
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

if [[ $MYMENU == *"nodejs"* ]]; then
    printstatus "Installing NodeJS"
	LATESTNODE="v12.16.3"
    if [[ $(uname -m) == *"armv6"* ]]; then
        printstatus "Installing ARM6 version"
        wget --no-check-certificate https://nodejs.org/dist/$LATESTNODE/node-$LATESTNODE-linux-armv6l.tar.xz -a $LOGFILE
        [ $? -eq 0 ] && nodejs=1
        pv node-$LATESTNODE-linux-armv6l.tar.xz | tar -xJf -
        cd node-$LATESTNODE-linux-armv6l
        sudo cp -R * /usr/local/
        rm -f node-$LATESTNODE-linux-armv6l.tar.xz
    else
        if [[ $CHECK64 == *"aarch64"* ]]; then
            printstatus "Installing ARM64 version"
            wget --no-check-certificate https://nodejs.org/dist/$LATESTNODE/node-$LATESTNODE-linux-arm64.tar.xz -a $LOGFILE
            [ $? -eq 0 ] && nodejs=1
            pv node-$LATESTNODE-linux-arm64.tar.xz | tar -xJf -
            cd node-$LATESTNODE-linux-arm64
            sudo cp -R * /usr/local/
            rm -f node-$LATESTNODE-linux-arm64.tar.xz
        else
            sudo apt-get $AQUIET -y remove --purge nodejs nodejs-legacy npm  2>&1 | tee -a $LOGFILE 
            sudo apt-get $AQUIET -y autoremove 2>&1 | tee -a $LOGFILE
            curl -sL https://deb.nodesource.com/setup_6.x > nodesetup.sh
            #curl -sL https://deb.nodesource.com/setup_8.x > nodesetup.sh
            sudo bash nodesetup.sh 2>&1 | tee -a $LOGFILE
            sudo apt-get $AQUIET -y install nodejs 2>&1 | tee -a $LOGFILE
            sudo apt-get $AQUIET -y install npm 2>&1 | tee -a $LOGFILE 
            sudo npm $NQUIET install npm@latest -g 2>&1 | tee -a $LOGFILE
 #           sudo apt-get $AQUIET -y remove --purge npm 2>&1 | tee -a $LOGFILE 
 #           sudo apt-get $AQUIET -y autoremove 2>&1 | tee -a $LOGFILE
            sudo ln -sf /usr/local/bin/npm /usr/bin
           [ $? -eq 0 ] && nodejs=1
        fi
    fi
    if [ $nodejs -ne 1 ]; then
        printl "${IRed}!!!! NodeJS not installed! ${IWhite}\r\n"
    fi
fi

if [[ $MYMENU == *"nodered"* ]]; then
    #sudo npm cache clean
    printstatus "Installing Node-Red"
    # if nodejs does not exist, abort node-red install
    if [ -f /usr/bin/node ] || [ -f /usr/local/bin/node ]; then
        # prevent double additions to settings.js if it exists and is already modified
        if [ $(grep public ~/.node-red/settings.js 2> /dev/null | wc -l) -ne 1 ]; then
            # sudo npm $NQUIET install -g npm node-gyp node-pre-gyp 2>&1 | tee -a $LOGFILE
            sudo npm $NQUIET install -g --unsafe-perm node-red 2>&1 | tee -a $LOGFILE
            if [[ $MYMENU == *"phone"* ]]; then
                sudo wget -a $LOGFILE -O /etc/init.d/nodered https://gist.githubusercontent.com/bigmonkeyboy/9962293/raw/0fe19671b1aef8e56cbcb20f6677173f8495e539/nodered
                sudo chmod 755 /etc/init.d/nodered && sudo update-rc.d nodered defaults 2>&1 | tee -a $LOGFILE
            else
                echo | openssl s_client -showcerts -servername raw.githubusercontent.com -connect raw.githubusercontent.com:443 2>/dev/null | openssl x509 -inform pem -noout -text > /dev/null 2>&1
                [[ $? -ne 0 ]] && echo 151.101.128.133 raw.githubusercontent.com | sudo tee -a /etc/hosts
                sudo wget -a $LOGFILE --no-check-certificate https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/nodered.service -O /lib/systemd/system/nodered.service
                sudo wget -a $LOGFILE --no-check-certificate https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/node-red-start -O /usr/bin/node-red-start
                sudo wget -a $LOGFILE --no-check-certificate https://raw.githubusercontent.com/node-red/raspbian-deb-package/master/resources/node-red-stop -O /usr/bin/node-red-stop
                #sudo sed -i -e 's#=pi#=%USER#g' /lib/systemd/system/nodered.service
                sudo chmod +x /usr/bin/node-red-st*
                sudo systemctl daemon-reload 2>&1 | tee -a $LOGFILE
            fi
            
            cd
            mkdir .node-red
            cd .node-red
            printstatus "Installing Nodes (could take some time)"
	for addonnodes in moment node-red-contrib-config node-red-contrib-grove node-red-contrib-diode node-red-contrib-bigtimer \
	node-red-contrib-esplogin node-red-contrib-timeout node-red-node-openweathermap node-red-node-google node-red-contrib-advanced-ping node-red-node-emoncms node-red-node-geofence node-red-contrib-moment node-red-contrib-particle \
	node-red-contrib-web-worldmap node-red-contrib-ramp-thermostat node-red-contrib-fs-ops node-red-contrib-influxdb \
	node-red-contrib-isonline node-red-node-ping node-red-node-random node-red-node-smooth node-red-contrib-npm node-red-node-arduino \
	node-red-contrib-file-function node-red-contrib-boolean-logic node-red-contrib-blynk-ws node-red-contrib-telegrambot node-red-contrib-dsm node-red-contrib-ftp \
	node-red-dashboard node-red-contrib-owntracks node-red-contrib-alexa-local node-red-contrib-amazon-echo node-red-contrib-alexa-notifyme node-red-contrib-heater-controller ; do
		printstatus "Installing node \"${addonnodes}\""
		npm $NQUIET install --save ${addonnodes} 2>&1 | tee -a $LOGFILE
	done
	
	printstatus "Installing node \"node-red-node-sqlite\""
	npm $NQUIET install --unsafe-perm node-red-node-sqlite 2>&1 | tee -a $LOGFILE

	if [[ $MYMENU == *"hwsupport"* ]]; then
		printstatus "Installing nodes \"serialport and i2c-bus\""
		npm $NQUIET install node-red-node-serialport i2c-bus 2>&1 | tee -a $LOGFILE
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
                #npm $NQUIET install node-red-contrib-gpio 2>&1 | tee -a $LOGFILE
                #npm $NQUIET install raspi-io 2>&1 | tee -a $LOGFILE
			else
				if [[ $MYMENU == *"generich3"* ]]; then
					npm $NQUIET install node-red-contrib-opi-gpio 2>&1 | tee -a $LOGFILE
				fi
            fi
		sudo sed -i -e 's#exit 0#chmod 777 /dev/ttyS*\nexit 0#g' /etc/rc.local
	fi
            
            cd ~/.node-red/
	 		sudo wget -a $LOGFILE $AQUIET https://tech.scargill.net/iot/settings.txt -O settings.js

            #sudo service nodered start 2>&1 | tee -a $LOGFILE
			#while [ ! -f settings.js ] ; do sudo sleep 1 ; done
			#sudo service nodered stop  2>&1 | tee -a $LOGFILE
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

            #datetimestamp=`date +%Y-%m-%d_%Hh%Mm`
            #cd ~/.node-red
            # this will add the TOP piece of code for non-vol variables in settings.js
            #gawk -i inplace -v INPLACE_SUFFIX=-$datetimestamp '!found && /module.exports/ { print " var mySettings;\n try {\n mySettings = require(\"/home/pi/.node-red/redvars.js\");\n } catch(err) {\n mySettings = {};\n }\n"; found=1 } 1' settings.js
            
            #sudo sed -i -e 's#functionGlobalContext: {#\/\/ functionGlobalContext: {#g' settings.js
            #sudo sed -i -e 's#\s\s\s\s\},#    \/\/ },#g' settings.js
            #sudo sed -i -e 's#^\}#,#g' settings.js
            #sudo echo " " > tmpfile
            #sudo echo "    httpStatic: '/home/pi/.node-red/public'," >> tmpfile
            #sudo echo "    functionGlobalContext: {" >> tmpfile
            #sudo echo "        os:require('os')," >> tmpfile
            #sudo echo "        moment:require('moment'), " >> tmpfile
            #sudo echo "        fs:require('fs'), " >> tmpfile
            #sudo echo "        i2c:require('i2c-bus'), " >> tmpfile
            #sudo echo "        mySettings:mySettings " >> tmpfile
            #sudo echo "    }," >> tmpfile
            #sudo echo " " >> tmpfile
            #sudo echo "    adminAuth: {" >> tmpfile
            #sudo echo "        type: \"credentials\"," >> tmpfile
            #sudo echo "        users: [{" >> tmpfile
            #sudo echo "            username: \"$adminname\"," >> tmpfile
            #sudo echo "            password: \"$bcryptadminpass\"," >> tmpfile
            #sudo echo "            permissions: \"*\"" >> tmpfile
            #sudo echo "        }]" >> tmpfile
            #sudo echo "    }," >> tmpfile
            #sudo echo " " >> tmpfile
            #sudo echo "    httpNodeAuth: {user:\"$username\", pass:\"$bcryptuserpass\"}" >> tmpfile
            #sudo echo "}" >> tmpfile
            #sudo cat tmpfile >> settings.js
            #sudo rm -f tmpfile
        else
            printl "${IRed}!!!! Settings.JS already present and modified, skipping! ${IWhite}\r\n"
        fi
        #sed -i -e 's#\/\/\s*var fs = require("fs");#var fs = require("fs");\nvar i2c = require("i2c-bus");#' /home/pi/.node-red/settings.js
		## The next two lines are new (Sept 2017) and change the flows files to non-host-specific names - good for copying
		#sed -i -e 's#\/\/flowFile#flowFile#' /home/pi/.node-red/settings.js
        #sed -i -e 's#\/\/flowFilePretty#flowFilePretty#' /home/pi/.node-red/settings.js
		#sed -i -e 's#\/\/ Customising#},\n\n    \/\/ Customising#' /home/pi/.node-red/settings.js
        if [[ $MYMENU == *"phone"* ]]; then
            cd && sudo mv /etc/init.d/sendsigs .
        else
            sudo systemctl enable nodered.service 2>&1 | tee -a $LOGFILE
        fi
		## add a nice little command line utility (nrlog) for showing and tailing Node-Red scripts in colour
	    echo "alias nrlog='sudo journalctl -f -n 50 -u nodered -o cat | ccze -A'" | sudo tee -a /etc/bash.bashrc > /dev/null 2>&1
    else
        printl "${IRed}!!!! Node-Red not installed! ${IWhite}\r\n"
    fi
fi

if [[ $MYMENU == *"hwsupport"* ]]; then
	if [[ $OPSYS != *"RASPBIAN"* ]]; then
		if [[ $MYMENU == *"odroid"* ]]; then
			printstatus "Installing Odroid GPIO"
			git clone https://github.com/hardkernel/wiringPi.git 2>&1 | tee -a $LOGFILE
			cd wiringPi
			./build 2>&1 | tee -a $LOGFILE
			sudo chmod a+s /usr/local/bin/gpio
		fi
		if [[ $MYMENU == *"generich3"* ]]; then
			printstatus "Installing H3 GPIO"
			# Install NanoPi H3 based IO library
			git clone https://github.com/zhaolei/WiringOP.git -b h3 2>&1 | tee -a $LOGFILE
			cd WiringOP
			chmod +x ./build
			sudo ./build 2>&1 | tee -a $LOGFILE
			cd
		fi
	fi
fi

if [[ $MYMENU == *"webmin"* ]]; then
    printstatus "Installing Webmin at port 10000 (could take some time)"
    #cd
    #mkdir webmin
    #cd webmin
    #wget --no-check-certificate http://prdownloads.sourceforge.net/webadmin/webmin-1.930.tar.gz
    #sudo gunzip -q webmin-1.831.tar.gz
    #tar -xf webmin-1.831.tar
    #sudo rm *.tar
    #cd webmin-1.831
    #sudo ./setup.sh /usr/local/Webmin
    wget -a $LOGFILE http://www.webmin.com/jcameron-key.asc -O - | sudo apt-key add -
    echo "deb http://download.webmin.com/download/repository sarge contrib" | sudo tee /etc/apt/sources.list.d/webmin.list > /dev/null
    sudo apt-get $AQUIET -y update 2>&1 | tee -a $LOGFILE
    sudo apt-get $AQUIET -y install webmin 2>&1 | tee -a $LOGFILE
    # http vs https: if you want unsecure http access on port 10000 instead of https, uncomment next line
    sudo sed -i -e 's#ssl=1#ssl=0#g' /etc/webmin/miniserv.conf
fi

#
# This works a treat on the NanoPi NEO using H3 and Armbian - should not do any harm on other systems as it's not installed!
#
if [[ $MYMENU == *"opi"* ]]; then
    printstatus "Installing Armbian Monitor"
    sudo armbianmonitor -r 2>&1 | tee -a $LOGFILE
fi

if [[ $MYMENU == *"java"* ]]; then
    printstatus "Installing/Updating Java"
	sudo apt-get $AQUIET -y install software-properties-common dirmngr 2>&1 | tee -a $LOGFILE
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886 2>&1 | tee -a $LOGFILE
	sudo apt-key adv --keyserver hkp://pgpkeys.mit.edu:80 --recv-keys C2518248EEA14886 2>&1 | tee -a $LOGFILE
	sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys EA8CACC073C3DB2A 2>&1 | tee -a $LOGFILE
	if [[ $OPSYS == *"BIAN"* ]] && [[ $DISTRO == *"10"* ]]; then
		sudo apt-get $AQUIET -y install openjdk-11-jre 2>&1 | tee -a $LOGFILE
#	leave the Oracle Java commented out until Oracle fixes the 404 file not found error in ITS official package...
#		echo "deb http://ppa.launchpad.net/linuxuprising/java/ubuntu bionic main" | sudo tee /etc/apt/sources.list.d/java.list
#		echo "deb-src http://ppa.launchpad.net/linuxuprising/java/ubuntu bionic main" | sudo tee -a /etc/apt/sources.list.d/java.list
#		sudo apt-get $AQUIET update 2>&1 | tee -a $LOGFILE
#		echo oracle-java12-installer shared/accepted-oracle-license-v1-2 select true | sudo /usr/bin/debconf-set-selections
#		echo oracle-java12-installer shared/accepted-oracle-licence-v1-2 boolean true | sudo /usr/bin/debconf-set-selections
#		echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
#		echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
# 		sudo apt-get $AQUIET -y install oracle-java12-installer oracle-java12-set-default 2>&1 | tee -a $LOGFILE
    else
		echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/java.list
		echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu xenial main" | sudo tee -a /etc/apt/sources.list.d/java.list
		sudo apt-get $AQUIET update 2>&1 | tee -a $LOGFILE
		echo debconf shared/accepted-oracle-license-v1-1 select true | sudo debconf-set-selections
		echo debconf shared/accepted-oracle-license-v1-1 seen true | sudo debconf-set-selections
		sudo apt-get $AQUIET -y install oracle-java8-installer 2>&1 | tee -a $LOGFILE
	fi
fi


if [[ $MYMENU == *"phpsysinfo"* ]]; then
    printstatus "Installing PHPSysInfo"
    #	sudo apt-get $AQUIET -y install phpsysinfo
    #	sudo ln -s /usr/share/phpsysinfo /var/www/html
    if [ -d /var/www/html ]; then
		cd /var/www/html
		sudo git clone https://github.com/phpsysinfo/phpsysinfo.git 2>&1 | tee -a $LOGFILE
		sudo cp /var/www/html/phpsysinfo/phpsysinfo.ini.new /var/www/html/phpsysinfo/phpsysinfo.ini
    else
        printl "${IRed}!!!! Apache+PHP not installed! ${IWhite}\r\n"
    fi
fi

# you may want to use these on a Pi or elsewhere to force either a graphical or command line environment
#sudo systemctl set-default multi-user.target
#sudo systemctl set-default graphical.target

if [[ $MYMENU == *"rpiclone"* ]]; then
    printstatus "Installing RPI-Clone"
	cd
	sudo git clone https://github.com/billw2/rpi-clone.git
	cd rpi-clone
	sudo cp rpi-clone /usr/local/sbin
	cd
	sudo rm -r rpi-clone
fi

if [[ $MYMENU == *"log2ram"* ]]; then
    printstatus "Installing Log2Ram"
    cd
	git clone https://github.com/azlux/log2ram.git 2>&1 | tee -a $LOGFILE
    cd log2ram
    chmod +x install.sh
    sudo ./install.sh 2>&1 | tee -a $LOGFILE
	cd
fi

# Drop in an index file and css for a menu page
if [[ $MYMENU == *"addindex"* ]]; then
    printstatus "Adding index page and CSS"
    if [ -d /var/www/html ]; then
 		sudo wget -a $LOGFILE $AQUIET https://www.scargill.net/iot/index.html -O /var/www/html/index.html
		sudo wget -a $LOGFILE $AQUIET https://www.scargill.net/iot/reset.css -O /var/www/html/reset.css
    else
        printl "${IRed}!!!! Apache+PHP not installed! ${IWhite}\r\n"
    fi
fi

if [[ $MYMENU == *"grafana"* ]]; then
        printstatus "Installing Grafana and Influxdb"
        cd
        sudo apt-get $AQUIET -y update 2>&1 | tee -a $LOGFILE
        sudo apt-get $AQUIET install -y apt-transport-https curl 2>&1 | tee -a $LOGFILE
        curl -sL https://repos.influxdata.com/influxdb.key | sudo apt-key add -
        test $VERSION_ID = "8" && echo "deb https://repos.influxdata.com/debian jessie stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
        test $VERSION_ID = "9" && echo "deb https://repos.influxdata.com/debian stretch stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
        test $VERSION_ID = "10" && echo "deb https://repos.influxdata.com/debian buster stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
        test $VERSION_ID = "16.04" && echo "deb https://repos.influxdata.com/ubuntu xenial stable" | sudo tee /etc/apt/sources.list.d/influxdb.list
        curl -sL https://bintray.com/user/downloadSubjectPublicKey?username=bintray | sudo apt-key add -
        curl -sL https://packages.grafana.com/gpg.key | sudo apt-key add -
        [[ $OPSYS == *"BIAN"* ]] && [[ $(uname -m) == *"armv6"* ]] && echo "deb https://dl.bintray.com/fg2it/deb-rpi-1b jessie main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
        [[ $OPSYS == *"BIAN"* ]] && [[ $(uname -m) != *"armv6"* ]] && echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
        [[ $OPSYS == *"UBUNTU"* ]] && echo "deb https://packages.grafana.com/oss/deb stable main" | sudo tee -a /etc/apt/sources.list.d/grafana.list
        sudo apt-get $AQUIET -y remove --purge grafana grafana-data 2>&1 | tee -a $LOGFILE
        sudo rm -rf /var/log/grafana /etc/grafana
        sudo apt-get $AQUIET -y autoremove 2>&1 | tee -a $LOGFILE
        sudo apt-get $AQUIET -y update 2>&1 | tee -a $LOGFILE
        sudo apt-get install $AQUIET -y influxdb grafana chronograf 2>&1 | tee -a $LOGFILE
        [ $? -eq 0 ] && grafana=1 # grafana installed
        if [ $grafana -eq 1 ]; then
                #sudo sed -i -e 's/.*auth-enabled = false/  auth-enabled = true/g' /etc/influxdb/influxdb.conf
                sudo systemctl daemon-reload 2>&1 | tee -a $LOGFILE
                sudo systemctl enable influxdb 2>&1 | tee -a $LOGFILE
                sudo systemctl start influxdb 2>&1 | tee -a $LOGFILE
                sudo systemctl enable grafana-server 2>&1 | tee -a $LOGFILE
                sudo systemctl start grafana-server 2>&1 | tee -a $LOGFILE
                sudo systemctl enable chronograf 2>&1 | tee -a $LOGFILE
                sudo systemctl start chronograf 2>&1 | tee -a $LOGFILE
    else
        printl "${IRed}!!!! GRAFANA AND INFLUXDB NOT INSTALLED! ${IWhite}\r\n"
    fi
fi


cd
curl -s -S https://getmic.ro | bash
sudo apt install $AQUIET -y  xclip


sudo rm -rf /var/cache/apt/archives/apt-fast

sudo apt-get $AQUIET -y clean 2>&1 | tee -a $LOGFILE
myip=$(hostname -I)
thehostname=$(hostname)
echo $newhostname | sudo tee /etc/hostname > /dev/null 2>&1
sudo sed -i '/^127.0.1.1/ d' /etc/hosts > /dev/null 2>&1
echo 127.0.1.1 $newhostname | sudo tee -a /etc/hosts > /dev/null 2>&1
#sudo /etc/init.d/hostname.sh > /dev/null 2>&1

#printstatus "Installing Glances"
#sudo apt-get -y install python{,3}-setuptools 2>&1 | tee -a $LOGFILE
#sudo pip install glances 2>&1 | tee -a $LOGFILE
#sudo pip install bottle 2>&1 | tee -a $LOGFILE

printstatus "All done."
printf "${BIGreen}== ${BIYELLOW}When complete, remove the script from the /home/pi directory.\r\n"
printf "${BIGreen}==\r\n"
printf "${BIGreen}== ${BIPurple}Current IP: %s${BIWhite}\r\n" "$myip"
printf "${BIGreen}== ${BIPurple}Existing Hostname: %s  New Hostname: %s${BIWhite}\r\n\r\n" "$thehostname" "$newhostname"
echo -e Current IP: $myip  Hostname: $thehostname >> $LOGFILE
echo -e Hostname: $newhostname >> $LOGFILE
echo -e NPM: $(npm -v) >> $LOGFILE
echo -e PHP: $(php -v) >> $LOGFILE
echo -e NODE: $(node -v) >> $LOGFILE
echo -e MQTT: $(/usr/sbin/mosquitto --help | grep version) >> $LOGFILE
sudo grep -h ^deb /etc/apt/sources.list /etc/apt/sources.list.d/* 2>&1 >> $LOGFILE
echo "alias space='df -h|grep -v udev|grep -v tmpfs|grep -v run'" | sudo tee -a /etc/bash.bashrc > /dev/null 2>&1

if [ ! -f /home/pi/AlreadyBashed ]; then
	sudo touch /home/pi/AlreadyBashed

sudo wget -a $LOGFILE $AQUIET https://www.scargill.net/iot/bashrc.txt -O /tmp/bashrc.txt
cat /tmp/bashrc.txt | sudo tee -a /etc/bash.bashrc > /dev/null 2>&1		

sudo tee -a /etc/profile > /dev/null <<EOT
export MICRO_TRUECOLOR=1
export COLORTERM=24bit
EOT

fi

printstatus  "COMPLETE - REBOOT NOW"

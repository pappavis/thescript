
printstatus "Welcome to 'The Script'"
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


AQUIET="-qq"
NQUIET="-s"
export npm_config_loglevel=silent


sudo apt-get update -y && sudo apt-get upgrade
sudo apt-get install -y p7zip-full mc  sqlite3
sudo apt-get install -y gedit vsftpd 
sudo apt-get install -y apache2 php php-mysql
sudo apt-get install -y nodejs npm

echo  alias ls="ls -F --color=auto" >> ~/.profile
echo  alias l="ls -F --color=auto" >> ~/.profile
echo  alias ll="ls -lF --color=auto" >> ~/.profile
echo  alias la="ls -lFa --color=auto" >> ~/.profile
echo   ~/venv/venv3.7/bin/activate >> ~/.profile

python3 -m pip install --user pipx
python3 -m pipx ensurepath
mkdir ~/venv
source ~/.bashrc

pipx install virtualenv
mkdir ~/venv
virtualenv ~/venv/venv3.7

echo "doen usermod"
sudo usermod -aG gpio pi
sudo usermod -aG dialout pi
sudo usermod -aG i2c pi
sudo usermod -aG tty pi

sudo adduser michiele
sudo usermod -aG sudo michiele
sudo usermod -aG gpio michiele
sudo usermod -aG dialout michiele
sudo usermod -aG i2c michiele
sudo usermod -aG spi michiele
sudo usermod -aG tty michiele

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

printstatus "Installing nodes \"serialport and i2c-bus\""
npm $NQUIET install node-red-node-serialport i2c-bus 2>&1 | tee -a $LOGFILE

getent group gpio || sudo groupadd gpio 2>&1 | tee -a $LOGFILE
getent group gpio | grep -w -l pi || sudo adduser pi gpio 2>&1 | tee -a $LOGFILE

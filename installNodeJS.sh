#!/bin/bash
LOGFILE=$HOME/logs/installNodeJS-`date +%Y-%m-%d_%Hh%Mm`.log
mkdir ~/logs

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

echo "Verwijderen oude NodeJS installaties"  2>&1 | tee -a $LOGFILE

for addonnodes in npm node nodejs ; do
	printstatus "Verwijderen oude npm install item: \"${addonnodes}\""
	sudo apt remove -y ${addonnodes} 2>&1 | tee -a $LOGFILE
	sudo apt purge -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

echo "Verwijderen oude NodeJS mappen in /usr/local"  2>&1 | tee -a $LOGFILE
sudo rm -rf /usr/local/bin/npm /usr/local/share/man/man1/node* ~/.npm  2>&1 | tee -a $LOGFILE
sudo rm -rf /usr/local/lib/node*  2>&1 | tee -a $LOGFILE
sudo rm -rf /usr/local/bin/node*  2>&1 | tee -a $LOGFILE
sudo rm -rf /usr/local/include/node*  2>&1 | tee -a $LOGFILE

sudo apt autoremove -y  2>&1 | tee -a $LOGFILE
sudo apt autoclean -y  2>&1 | tee -a $LOGFILE
cd ~/Downloads

echo "NodeJS opnieuw installeren." 2>&1 | tee -a $LOGFILE

if [ $(nproc) == 1 ]; then
	echo "NodeJS  installeren op een Pi Zero" 2>&1 | tee -a $LOGFILE
	wget https://unofficial-builds.nodejs.org/download/release/v17.3.0/node-v17.3.0-linux-armv6l.tar.gz 2>&1 | tee -a $LOGFILE
	tar xzf node-v17.3.0-linux-armv6l.tar.gz 2>&1 | tee -a $LOGFILE
	sudo cp -R ./node-v17.3.0-linux-armv6l /usr/local 2>&1 | tee -a $LOGFILE
else
	echo "NodeJS  installeren op een Pi3,4" 2>&1 | tee -a $LOGFILE
	## zie https://www.digitalocean.com/community/tutorials/how-to-install-node-js-on-ubuntu-16-04
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash 2>&1 | tee -a $LOGFILE
	nvm install v17.13.1 2>&1 | tee -a $LOGFILE
	nvm use v17.13.1
fi


printstatus "NodeJS $(node -v) en npm $(npm -v) is geïnstalleerd" 2>&1 | tee -a $LOGFILE


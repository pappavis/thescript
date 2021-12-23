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

printstatus "Verwijderen oude NodeJS installaties"
sudo rm -rf /usr/local/bin/npm /usr/local/share/man/man1/node* ~/.npm  2>&1 | tee -a $LOGFILE
sudo rm -rf /usr/local/lib/node*  2>&1 | tee -a $LOGFILE
sudo rm -rf /usr/local/bin/node*  2>&1 | tee -a $LOGFILE
sudo rm -rf /usr/local/include/node*  2>&1 | tee -a $LOGFILE

sudo apt purge nodejs npm node -y  2>&1 | tee -a $LOGFILE
sudo apt autoremove -y  2>&1 | tee -a $LOGFILE
cd ~/Downloads

printstatus "NodeJS opnieuw installeren."
wget https://unofficial-builds.nodejs.org/download/release/v17.3.0/node-v17.3.0-linux-armv6l.tar.gz 2>&1 | tee -a $LOGFILE
tar xzf node-v17.3.0-linux-armv6l.tar.gz 2>&1 | tee -a $LOGFILE
sudo cp -R ./node-v17.3.0-linux-armv6l /usr/local 2>&1 | tee -a $LOGFILE

printstatus "NodeJS $(node -v) en npm $(npm -v) is geïnstalleerd". 2>&1 | tee -a $LOGFILE


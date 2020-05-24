OPSYS = "RASPBIAN"
MYMENU == "hwsupport"
LOGFILE=$HOME/$0-`date +%Y-%m-%d_%Hh%Mm`.log
adminpass="rider506"
userpass="rider506"

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

echo "Installing NodeJS"
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

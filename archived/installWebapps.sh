OPSYS = "RASPBIAN"
MYMENU == "hwsupport"
LOGFILE=$HOME/$0-`date +%Y-%m-%d_%Hh%Mm`.log

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


if [1==1]; then
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
if [1==1]; then
    printstatus "Installing Armbian Monitor"
    sudo armbianmonitor -r 2>&1 | tee -a $LOGFILE
fi



if [1==1]; then
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


if [1==1]; then
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


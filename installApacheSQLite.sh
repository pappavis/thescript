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

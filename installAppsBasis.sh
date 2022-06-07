#!/bin/bash
LOGFILE=$HOME/logs/installAppsBasis-`date +%Y-%m-%d_%Hh%Mm`.log

sudo apt-add-repository "deb http://ppa.launchpad.net/ubuntu-mozilla-security/ppa/ubuntu focal main" 2>&1 | tee -a $LOGFILE
sudo apt update -y 2>&1 | tee -a $LOGFILE
sudo apt update --fix-missing -y  2>&1 | tee -a $LOGFILE

for addonnodes in p7zip-full mc sqlite3 i2c-tools ncftp mariadb-server mariadb-client mosquitto mosquitto-clients python3 python3-pip python3-opencv libsdl2-image gedit gparted  python-smbus vsftpd neofetch apache2 php php-mysql php-sqlite3 php-mbstring openssl libapache2-mod-php php-sqlite3 php-xml php-mbstring sysbench open-cobol ffmpeg wiringpi rpi.gpio  unixodbc-dev npm node python-is-python3 dosbox usbip sendmail libopencv-dev mutt alpine pilot mh-e elmo nmap curl virtualenv python3-virtualenv redis-server ; do 
	echo ""  2>&1 | tee -a $LOGFILE
	echo "--Installeren  \"${addonnodes}\""  2>&1 | tee -a $LOGFILE
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in build-essential cmake rapidjson-dev libgmp-dev git gcc g++ netdiscover sysfsutils tcpdump vsftpd wget  ssh bash-completion unzip build-essential git python-serial scons libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libsqlite3-dev subversion libusb-dev python-dev python3-dev cmake curl telnet usbutils gawk jq pv samba samba-common samba-common-bin smbclient winbind dosfstools parted gcc python3-pip htop python-smbus mc cu mpg123 screen ffmpeg qemu-system default-jdk openvpn lynx clonezilla yum telnet lynx docker dnsutils clamav clamav-daemon ; do
	echo ""  2>&1 | tee -a $LOGFILE
	echo "--Installeren  \"${addonnodes}\""  2>&1 | tee -a $LOGFILE
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in libatlas3-base qtchooser imagemagick libfontconfig1-dev libcairo2-dev libgdk-pixbuf2.0-dev libpango1.0-dev libgtk2.0-dev libgtk-3-dev libatlas-base-dev gfortran libssl libcurl4-gnutls-dev libcurl4-openssl-dev libcurl4-openssl-dev  libsdl2-ttf-dev libsdl2-image-dev ccze net-tools ntfs-3g php-intl i2c-tools python3-rpi.gpio libgstreamer-plugins-base1.0-dev ; do 
	echo ""  2>&1 | tee -a $LOGFILE
	echo "--Installeren  \"${addonnodes}\""  2>&1 | tee -a $LOGFILE
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done


for addonnodes in libatlas3-base qtchooser imagemagick libfontconfig1-dev libcairo2-dev libgdk-pixbuf2.0-dev libpango1.0-dev libgtk2.0-dev libgtk-3-dev libatlas-base-dev gfortran libssl libcurl4-gnutls-dev libcurl4-openssl-dev libcurl4-openssl-dev  libsdl2-ttf-dev libsdl2-image-dev ccze net-tools ntfs-3g php-intl i2c-tools python3-rpi.gpio libgstreamer-plugins-base1.0-dev rapidjson-dev ; do 
	echo ""  2>&1 | tee -a $LOGFILE
	echo "--Installeren  \"${addonnodes}\""  2>&1 | tee -a $LOGFILE
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

echo ""  2>&1 | tee -a $LOGFILE
echo  "vsftpd, wijzigen write_enable"  2>&1 | tee -a $LOGFILE
sudo sed -i -e '/#write_enable/s/#write_enable/write_enable/' /etc/vsftpd.conf
sudo service vsftpd restart
sudo service vsftpd status 2>&1 | tee -a $LOGFILE

sudo sed -i 's/upload_max_filesize = 2M/upload_max_filesize = 999M/g' /etc/php/7.4/apache2/php.ini 2>&1 | tee -a $LOGFILE

sudo apt update -y 2>&1 | tee -a $LOGFILE
sudo apt upgrade -y 2>&1 | tee -a $LOGFILE
sudo apt autoremove  -y 2>&1 | tee -a $LOGFILE
sudo apt autoclean  -y 2>&1 | tee -a $LOGFILE

echo ""  2>&1 | tee -a $LOGFILE
echo "Einde installAppsBasis"  2>&1 | tee -a $LOGFILE
echo ""  2>&1 | tee -a $LOGFILE

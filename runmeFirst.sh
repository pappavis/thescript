#!/bin/bash
LOGFILE=$HOME/logs/$0-`date +%Y-%m-%d_%Hh%Mm`.log
_pwd=$(pwd)

mkdir $HOME/logs

printl() {
	printf $1
	echo -e $1 >> $LOGFILE
}

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

printstatus "Welkom, setup een nieuwe Raspbian of Ubunto omgeving"


AQUIET="-qq"
NQUIET="-s"
export npm_config_loglevel=silent

echo "alias ls='ls -F --color=auto'" >> ~/.bashrc
echo "alias ll='ls -lF --color=auto'" >> ~/.bashrc
echo "alias la='ls -lFa --color=auto'" >> ~/.bashrc
echo "alias l='ls -F --color=auto'" >> ~/.bashrc

# install sudo on devices without it
[ ! -x /usr/bin/sudo ] && apt-get $AQUIET -y update > /dev/null 2>&1 && apt-get $AQUIET -y install sudo 2>&1 | tee -a $LOGFILE

sudo apt install -y git
sudo apt install -y python3-pip  2>&1 | tee -a $LOGFILE
pip install ensurepip  2>&1 | tee -a $LOGFILE

git config pull.rebase false
mkdir /home/pi/Downloads
cd /home/pi/Downloads
git clone https://github.com/pappavis/thescript/
cd /home/pi/Downloads/thescript

printstatus  "Swapfile vergroot van 100mb naar 2Gb"
sudo sed -i -e '/CONF_SWAPSIZE=100/s/100/2048/' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile restart

printstatus  "Bluetooth, wijzigen naar DicoverableTimeout=0"
sudo sed -i -e '/#DiscoverableTimeout = 0/s/#Discoverable/Discoverable/' /etc/bluetooth/main.conf
sudo service bluetooth restart

sudo apt update -y
sudo apt update --fix-missing -y  2>&1 | tee -a $LOGFILE

for addonnodes in p7zip-full mc sqlite3  i2c-tools ncftp mariadb-server mariadb-client mosquitto mosquitto-clients python3 python3-pip  python3-opencv libsdl2-image gedit gparted  python-smbus vsftpd neofetch nodejs npm 		apache2 php php-mysql php-sqlite3 php-mbstring openssl libapache2-mod-php php-sqlite3 php-xml php-mbstring sysbench open-cobol ffmpeg wiringpi rpi.gpio  unixodbc-dev npm node python-is-python3 ; do 
		printstatus "Installing  \"${addonnodes}\""
		sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
	done

printstatus  "Bijwerken vsftpd anonymous"
sudo sed -i -e '/anonymous_enable=NO/s/NO/YES/' /etc/vsftpd.conf
sudo sed -i -e '/#utf8_filesystem/s/#utf8/utf8/' /etc/vsftpd.conf
sudo service vsftpd restart

mkdir ~/Downloads
cd ~
wget https://raw.githubusercontent.com/pappavis/thescript/master/index_apps.php 2>&1 | tee -a $LOGFILE
sudo mv index_apps.php /var/www/html
sudo mv /var/www/html/index.html /var/www/html/index_orgig.php
cd $_pwd

VENV="venv3.7"
rm -rf ~/venv/$VENV
mkdir ~/venv
python3 -m pip install virtualenv
pip install virtualenv  2>&1 | tee -a $LOGFILE
~/.local/bin/virtualenv ~/venv/$VENV
echo "source ~/venv/$VENV/bin/activate" >> ~/.bashrc
source ~/.bashrc
echo "Virtualenv versie: $(python -V)"
echo "PATH=$PATH:~/.local/bin" >> ~/.bashrc


printstatus "Toestaan remote root login en sneller SSH"
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

printstatus "Adding user Pi permissions"
for additionalgroup in cdrom games users i2c adm gpio input sudo netdev audio video dialout plugdev bluetooth ; do
	getent group ${additionalgroup} | grep -w -l pi || sudo adduser pi ${additionalgroup} 2>&1 | tee -a $LOGFILE
done


printstatus  "doen usermod"  2>&1 | tee -a $LOGFILE

for addonnodes in gpio dialout i2c tty kmem uinput ; do
	printstatus "Usermmod pi \"${addonnodes}\""
	sudo usermod pi -aG ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in build-essential cmake rapidjson-dev libgmp-dev git gcc g++ netdiscover sysfsutils tcpdump vsftpd wget ssh bash-completion unzip build-essential git python-serial scons libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libsqlite3-dev subversion libusb-dev python-dev cmake curl telnet usbutils gawk jq pv samba samba-common samba-common-bin winbind dosfstools parted gcc python3-pip htop python-smbus mc cu mpg123 screen ffmpeg qemu-system default-jdk ; do
	printstatus "Instelleren \"${addonnodes}\""
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in libatlas3-base qtchooser imagemagick libfontconfig1-dev libcairo2-dev libgdk-pixbuf2.0-dev libpango1.0-dev libgtk2.0-dev libgtk-3-dev libatlas-base-dev gfortran libssl libcurl4-gnutls-dev libcurl4-openssl-dev libcurl4-openssl-dev  libsdl2-ttf-dev libsdl2-image-dev ccze net-tools ntfs-3g default-jdk ; do 
		printstatus "Installing  \"${addonnodes}\""
		sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

./adduserPi.sh
	    
sudo usermod -aG sudo michiele
sudo usermod -aG sudo pi
sudo usermod -aG gpio michiele
sudo usermod -aG dialout michiele
sudo usermod -aG i2c michiele
sudo usermod -aG spi michiele
sudo usermod -aG tty michiele
sudo usermod -aG kmem michiele

sudo mv /var/www/html/index.html /var/www/html/orig_index.html
sudo apt full-upgrade -y 2>&1 | tee -a $LOGFILE
sudo apt autoclean -y  2>&1 | tee -a $LOGFILE
sudo apt autoremove -y 2>&1 | tee -a $LOGFILE

sudo sed -i "s/# nl_NL.utf8/nl_NL.utf8/g" /etc/locale.gen
sudo locale-gen

cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/welkom1.sh
chmod +x ./welkom1.sh
sudo mv ./welkom1.sh /usr/local/bin
welkom1.sh

echo ""
echo "Je kunt nu REBOOT, daarna ./installVerzamelupdates.sh draaien"

## neofetch
lsblk
cd $_pwd
## bash ./installVerzamelupdates.sh

##bash ./setupNodered.sh

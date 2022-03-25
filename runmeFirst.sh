#!/bin/bash
LOGFILE=$HOME/logs/runmeFirst-`date +%Y-%m-%d_%Hh%Mm`.log
_pwd=$(pwd)

mkdir $HOME/logs
logdir1=/home/pi/logs
echo "Logmap aangemaakt $logdir1" 2>&1 | tee -a $LOGFILE

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

echo "Instellen alias voor 'ls'"   2>&1 | tee -a $LOGFILE
echo "alias ls='ls -F --color=auto'" 2>&1 | sudo tee -a /etc/bash.bashrc
echo "alias ll='ls -lF --color=auto'"  2>&1 | sudo tee -a /etc/bash.bashrc
echo "alias la='ls -lFa --color=auto'"  2>&1 | sudo tee -a /etc/bash.bashrc
echo "alias l='ls -F --color=auto'"  2>&1 | sudo tee -a /etc/bash.bashrc
echo "export LOGFILE=/home/pi/logs/logAlgemeen.txt"  2>&1 | sudo tee -a /etc/bash.bashrc
echo "export VISUAL=/usr/bin/nano"  2>&1 | sudo tee -a /etc/bash.bashrc

# install sudo on devices without it
[ ! -x /usr/bin/sudo ] && apt-get $AQUIET -y update > /dev/null 2>&1 && apt-get $AQUIET -y install sudo 2>&1 | tee -a $LOGFILE

sudo apt install -y git  2>&1 | tee -a $LOGFILE
sudo apt install -y python3-pip  2>&1 | tee -a $LOGFILE
pip3 install ensurepip  2>&1 | tee -a $LOGFILE
python3 -m pip install ensurepip 2>&1 | tee -a $LOGFILE

for addonnodes in  do_i2c  do_spi do_serial do_ssh do_camera disable_raspi_config_at_boot  ; do
    printstatus "Raspi-config instellingen activeren  : \"${addonnodes}\""
    sudo raspi-config nonint ${addonnodes} 0 2>&1 | tee -a $LOGFILE
done

echo "Instellen timezone naar Europe/Amsterdam" 2>&1 | tee -a $LOGFILE
rm -f /etc/localtime
echo "Europe/Amsterdam" >/etc/timezone
sudo dpkg-reconfigure -f noninteractive tzdata 2>&1 | tee -a $LOGFILE
sudo cat >/etc/default/keyboard <<'KBEOF'
XKBMODEL="pc105"
XKBLAYOUT="us"
XKBVARIANT=""
XKBOPTIONS=""
KBEOF
sudo dpkg-reconfigure -f noninteractive keyboard-configuration 2>&1 | tee -a $LOGFILE
sudo sed -i 's| systemd.run.*||g' /boot/cmdline.txt 2>&1 | tee -a $LOGFILE

sudo raspi-config nonint do_wifi_country  NL 2>&1 | tee -a $LOGFILE 
sudo raspi-config nonint do_change_locale nl_NL.UTF-8

cd $_pwd
git config pull.rebase false  2>&1 | tee -a $LOGFILE
mkdir /home/pi/Downloads 2>&1 | tee -a $LOGFILE
cd /home/pi/Downloads
git clone https://github.com/pappavis/thescript/  2>&1 | tee -a $LOGFILE
cd /home/pi/Downloads/thescript

printstatus  "Swapfile vergroot van 100mb naar 2Gb"  2>&1 | tee -a $LOGFILE
sudo sed -i -e '/CONF_SWAPSIZE=100/s/100/2048/' /etc/dphys-swapfile
sudo /etc/init.d/dphys-swapfile restart
sudo service dphys-swapfile status 2>&1 | tee -a $LOGFILE

printstatus  "Bluetooth, wijzigen naar DicoverableTimeout=0"  2>&1 | tee -a $LOGFILE
sudo sed -i -e '/#DiscoverableTimeout = 0/s/#Discoverable/Discoverable/' /etc/bluetooth/main.conf
sudo service bluetooth restart
sudo service bluetooth status 2>&1 | tee -a $LOGFILE

sudo apt update -y
sudo apt update --fix-missing -y  2>&1 | tee -a $LOGFILE

for addonnodes in p7zip-full mc sqlite3 i2c-tools ncftp mariadb-server mariadb-client mosquitto mosquitto-clients python3.11  python3-opencv libsdl2-image gedit gparted  python-smbus vsftpd neofetch apache2 php php-mysql php-sqlite3 php-mbstring openssl libapache2-mod-php php-sqlite3 php-xml php-mbstring sysbench open-cobol ffmpeg wiringpi rpi.gpio  unixodbc-dev npm node python-is-python3 dosbox usbip sendmail libopencv-dev ufw  ; do 
		printstatus "Installing  \"${addonnodes}\""
		sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
	done

printstatus  "Bijwerken vsftpd anonymous"  2>&1 | tee -a $LOGFILE
sudo sed -i -e '/anonymous_enable=NO/s/NO/YES/' /etc/vsftpd.conf
sudo sed -i -e '/#utf8_filesystem/s/#utf8/utf8/' /etc/vsftpd.conf
sudo service vsftpd restart

mkdir ~/Downloads
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/index_apps.php 2>&1 | tee -a $LOGFILE
sudo mv ./index_apps.php /var/www/html
sudo rm -rf /var/www/html/index.html

cd $_pwd

sudo apt remove python2 -y  2>&1 | tee -a $LOGFILE
sudo apt install python-is-python3 -y  2>&1 | tee -a $LOGFILE
VENV="venv"
rm -rf ~/venv/$VENV
mkdir ~/venv
python3 -m pip install virtualenv 2>&1 | tee -a $LOGFILE
/usr/python/python3.11 -m pip install virtualenv 2>&1 | tee -a $LOGFILE
~/.local/bin/virtualenv ~/venv/$VENV
~/.local/bin/virtualenv3.11 ~/venv/venv3.11
echo "source ~/venv/$VENV/bin/activate" >> ~/.bashrc
source ~/.bashrc
echo "Virtualenv versie: $(python -V)"
echo "PATH=$PATH:~/.local/bin" >> ~/.bashrc

printstatus "SSH keygen voor bij github checkouts" 2>&1 | tee -a $LOGFILE
#ssh-keygen -t rsa -f /home/pi/.ssh/github_rsa -q -P ""
sudo rm -rf /home/pi/.ssh/github_rsa*
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC53hBwC8gtq1BljXyOyb3OWBvhhMsEm4Ng2223wrGtE6v0gbNGyiaAIjynQNXURrOH7O0Kek1rVWEqGVxeEtlI0/YwwM9VQ/dLEszcVOv/dSvkQPjvYXZHRLt4BGpfk+UEevX+QhZ92ASNCT5eq3oUlrPeDCqadwiDK+vczovJInsBumNPB0hG8jSuIsKj6ALii2zet+xu7/zyJVqgHGVMyaKPjdbTIi5WIW1qfpLwT5g9tK7+2v2Ryn0EHQE8uIV789VYA7S4KL8PSamHd91VFKVoTu2MjicxGixwsogLod+ICg4NcLmU8HFMCBVdog9sculGApamHM2+jDzxJ3El pi@pi04" | tee /home/pi/.ssh/github_rsa.pub
echo "eval \$(ssh-agent -s)" | tee -a /etc/rc.local
sudo sed -i -e '/exit 0/s/exit 0/\$(ssh-agent -s)/' /etc/rc.local
echo "exit 0" 2>&1 | sudo tee -a /etc/rc.local
ssh-add /home/pi/.ssh/github_rsa 2>&1 | tee -a $LOGFILE

printstatus "Toestaan remote root login en sneller SSH" 2>&1 | tee -a $LOGFILE
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

printstatus "Adding user Pi permissions"  2>&1 | tee -a $LOGFILE
for additionalgroup in cdrom games users i2c adm gpio input sudo netdev audio video dialout plugdev bluetooth ; do
	getent group ${additionalgroup} | grep -w -l pi || sudo adduser pi ${additionalgroup} 2>&1 | tee -a $LOGFILE
done


printstatus  "doen usermod"  2>&1 | tee -a $LOGFILE

for addonnodes in gpio dialout i2c tty kmem uinput ; do
	printstatus "Usermmod pi \"${addonnodes}\""
	sudo usermod pi -aG ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in build-essential cmake rapidjson-dev libgmp-dev git gcc g++ netdiscover sysfsutils tcpdump vsftpd wget  ssh bash-completion unzip build-essential git python-serial scons libboost-filesystem-dev libboost-program-options-dev libboost-system-dev libsqlite3-dev subversion libusb-dev python-dev python3-dev cmake curl telnet usbutils gawk jq pv samba samba-common samba-common-bin winbind dosfstools parted gcc python3-pip htop python-smbus mc cu mpg123 screen ffmpeg qemu-system default-jdk openvpn lynx clonezilla yum telnet lynx ; do
	printstatus "Instelleren \"${addonnodes}\""
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in libatlas3-base qtchooser imagemagick libfontconfig1-dev libcairo2-dev libgdk-pixbuf2.0-dev libpango1.0-dev libgtk2.0-dev libgtk-3-dev libatlas-base-dev gfortran libssl libcurl4-gnutls-dev libcurl4-openssl-dev libcurl4-openssl-dev  libsdl2-ttf-dev libsdl2-image-dev ccze net-tools ntfs-3g php-intl i2c-tools python3-rpi.gpio ; do 
		printstatus "Installing  \"${addonnodes}\""
		sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

./adduserPi.sh  2>&1 | tee -a $LOGFILE

# ref https://doc.owncloud.com/server/next/user_manual/files/access_webdav.html
sudo apt install -y davfs


for addonnodes in sudo gpio dialout i2c spi tty kmem ; do 
	printstatus "usermod  \"${addonnodes}\""
	sudo usermod -aG  ${addonnodes} michiele  2>&1 | tee -a $LOGFILE
	sudo usermod -aG  ${addonnodes} pi  2>&1 | tee -a $LOGFILE
done


sudo mv /var/www/html/index.html /var/www/html/orig_index.html
sudo apt full-upgrade -y 2>&1 | tee -a $LOGFILE
sudo apt autoclean -y  2>&1 | tee -a $LOGFILE
sudo apt autoremove -y 2>&1 | tee -a $LOGFILE

sudo sed -i "s/# nl_NL.utf8/nl_NL.utf8/g" /etc/locale.gen
sudo locale-gen 2>&1 | tee -a $LOGFILE

echo "* Installeer btop proceslijst" 2>&1 | tee -a $LOGFILE
cd ~/Downloads/
sudo rm -rf ./btop*
mkdir ./btop_install
cd ./btop_install
wget https://github.com/aristocratos/btop/releases/download/v1.1.2/btop-1.1.2-armv5l-linux-musleabi.tbz 2>&1 | tee -a $LOGFILE
#wget https://github.com/aristocratos/btop/releases/download/v1.1.2/btop-1.1.2-armv7l-linux-musleabihf.tbz 2>&1 | tee -a $LOGFILE
7z x ./btop-1.1.2-armv5l-linux-musleabi.tbz  2>&1 | tee -a $LOGFILE
7z x ./btop-1.1.2-armv5l-linux-musleabi.tar
sudo make  2>&1 | tee -a $LOGFILE
cd ~/Downloads/
sudo rm -rf ./btop_install


printstatus  "Instellen Samba windows bestanddelen"  2>&1 | tee -a $LOGFILE
sudo sed -i -e '/workgroup = WORKGROUP/s/WORKGROUP/FRAMBOOS/' /etc/samba/smb.conf
echo "[Downloads]" | sudo tee -a  /etc/samba/smb.conf
echo "  comment = aflaai map" | sudo tee -a  /etc/samba/smb.conf
echo "  path = /home/pi/Downloads" | sudo tee -a  /etc/samba/smb.conf
echo "  guest ok = yes" | sudo tee -a  /etc/samba/smb.conf
echo "  browseable = yes" | sudo tee -a  /etc/samba/smb.conf
echo "  create mask = 0600" | sudo tee -a  /etc/samba/smb.conf
echo "  directory mask = 0700" | sudo tee -a  /etc/samba/smb.conf
echo "  writable = yes" | sudo tee -a  /etc/samba/smb.conf
echo "rider506\nrider506\n" | sudo smbpasswd -a pi
sudo service smbd restart
sudo service nmbd restart
sudo service smbd status 2>&1 | tee -a $LOGFILE

cd $_pwd
printstatus "NodeJS installeren" 2>&1 | tee -a $LOGFILE
sudo bash ./installNodeJS.sh 2>&1 | tee -a $LOGFILE

cd $_pwd
echo "Installeer Nodered en NodeJS" 2>&1 | tee -a $LOGFILE
bash ./installNodeJS.sh 2>&1 | tee -a $LOGFILE
echo "Installatie NodeJS $(node -v) en NPN $(npm -v) afgerond." 2>&1 | tee -a $LOGFILE

cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/welkom1.sh 2>&1 | tee -a $LOGFILE
chmod +x ./welkom1.sh
sudo mv ./welkom1.sh /usr/local/bin/welkom1
echo "welkom1" 2>&1 | sudo tee -a /etc/bash.bashrc

echo "Toevoegen ssh welkomtekstje" 2>&1 | tee -a $LOGFILE
sudo mkdir /usr/local/share/ssh_welkom
echo "╔═╗╔═╗╦ ╦" | sudo tee -a /usr/local/share/ssh_welkom/ssh_welkom.txt
echo "╚═╗╚═╗╠═╣" | sudo tee -a /usr/local/share/ssh_welkom/ssh_welkom.txt
echo "╚═╝╚═╝╩ ╩" | sudo tee -a /usr/local/share/ssh_welkom/ssh_welkom.txt
echo "" | sudo tee -a /usr/local/share/ssh_welkom/ssh_welkom.txt
echo "SSH aanmelden op $(hostname)" | sudo tee -a /usr/local/share/ssh_welkom/ssh_welkom.txt
sudo sed -i -e '/#Banner none/s/none/\/usr\/local\/share\/ssh_welkom\/ssh_welkom.txt/' /etc/ssh/sshd_config
sudo sed -i -e '/#Banner/s/#Banner/Banner/' /etc/ssh/sshd_config
sudo service ssh restart

cd $_pwd
echo "toevoegen printstatus() aan /etc/bash.bashrc" 2>&1 | tee -a $LOGFILE
cat ./installNutsfuncties.sh | sudo tee -a /etc/bash.bashrc

cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/crontab.default 2>&1 | tee -a $LOGFILE
sudo mv ./crontab.default /etc/crontab 2>&1 | tee -a $LOGFILE
sudo mkdir /etc/cron.daily
sudo mkdir /etc/cron.weekly
sudo mkdir /etc/cron.monthly
sudo service cron restart

echo "" 2>&1 | tee -a $LOGFILE

echo "Instellen herstartmelding" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/demo/herstartmelding.py 2>&1 | tee -a $LOGFILE
chmod +x ./herstartmelding.py
sudo mv ./herstartmelding.py /usr/local/bin
sudo ln -s /etc/cron.weekly/herstartmelding.py /usr/local/bin/herstartmelding.py 
sudo sed -i -e '/exit 0/s/exit 0/herstartmelding.py \&/' /etc/rc.local
# !!Je MOET onderataand exit 0 uitvoeren!!
echo "exit 0" 2>&1 | sudo tee -a /etc/rc.local

## neofetch
lsblk 2>&1 | tee -a $LOGFILE
cd $_pwd 2>&1 | tee -a $LOGFILE
## bash ./installVerzamelupdates.sh

##bash ./setupNodered.sh

echo "runmefirst EINDE" 2>&1 | tee -a $LOGFILE
echo "Je kunt nu HERSTART, daarna ./installVerzamelupdates.sh draaien" 2>&1 | tee -a $LOGFILE
exit 0

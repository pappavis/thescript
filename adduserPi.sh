_hn=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/adduserPi-`date +%Y-%m-%d_%Hh%Mm`.log
mkdir ~/logs
gebr="michiele"
wachtwoord="raspberry"

echo "* Nieuwe gebruiker wordt aangemaakt: $gebr"  2>&1 | tee -a $LOGFILE
sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/$gebr --gecos "User" $gebr
echo "$gebr:$wachtwoord" | sudo chpasswd
sudo usermod $gebr -g sudo -G ssh -a
sudo usermod $gebr -g dialout
sudo usermod $gebr -g tty
sudo usermod $gebr -g gpio
sudo usermod $gebr -g i2c


sudo echo "$gebr ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$gebr
sudo chmod 0440 /etc/sudoers.d/$gebr
sudo chmod 4755 /usr/bin/sudo
printf "${ICyan}gebruiker $gebr aangemaakt, wachtwoord is \"$wachtwoord\". Afmelden en opnieuw aanmelden indien gewenst ${IWhite}\r\n\r\n"
sudo cp $(readlink -f $0) /home/$gebr && chown $gebr.$gebr /home/$gebr/$0 && chmod 755 /home/$gebr/$0
sudo chown $gebr.$gebr $LOGFILE && sudo chmod 644 $LOGFILE && sudo cp $LOGFILE /home/$gebr
echo ""

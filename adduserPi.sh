_hn=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/adduserPi-`date +%Y-%m-%d_%Hh%Mm`.log
mkdir ~/logs
gebr="michiele"
wachtwoord="raspberry"

sudo usermod pi -g sudo -G ssh -a
echo "pi ALL=(ALL) NOPASSWD: ALL"  2>&1 | sudo tee -a /etc/sudoers.d/pi
sudo chmod 0440 /etc/sudoers.d/pi  2>&1 | tee -a $LOGFILE
sudo chmod 4755 /usr/bin/sudo  2>&1 | tee -a $LOGFILE
printf "${ICyan}user PI created, password is \"password\". Please log-out as root and login as pi, and redo the procedure ${IWhite}\r\n\r\n"  2>&1 | tee -a $LOGFILE
sudo cp $(readlink -f $0) /home/pi && sudo chown pi.pi /home/pi/$0 && sudo chmod 755 /home/pi/$0
sudo chown pi.pi $LOGFILE && sudo chmod 644 $LOGFILE && sudo cp $LOGFILE /home/pi


echo "* Nieuwe gebruiker wordt aangemaakt: $gebr"  2>&1 | tee -a $LOGFILE
sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/$gebr --gecos "User" $gebr
echo "$gebr:$wachtwoord" | sudo chpasswd

for addonnodes in dialout tty gpio i2c ; do
  echo "Gebruiker $gebr rechten toewijzen aan groep:  \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
  sudo usermod $gebr -g ${addonnodes}  2>&1 | tee -a $LOGFILE
done

echo "$gebr ALL=(ALL:ALL) NOPASSWD: ALL"  2>&1 | sudo tee /etc/sudoers.d/dont-prompt-$gebr-for-sudo-password
sed -e "$gebr ALL=(ALL) NOPASSWD: ALL" /etc/sudoers.d/$gebr
sudo chmod 0440 /etc/sudoers.d/$gebr  2>&1 | tee -a $LOGFILE
sudo chmod 4755 /usr/bin/sudo  2>&1 | tee -a $LOGFILE
printf "${ICyan}gebruiker $gebr aangemaakt, wachtwoord is \"$wachtwoord\". Afmelden en opnieuw aanmelden indien gewenst ${IWhite}\r\n\r\n"  2>&1 | tee -a $LOGFILE
sudo cp $(readlink -f) /home/$gebr && chown $gebr.$gebr -R /home/$gebr/ && chmod 755 /home/$gebr/
echo ""  2>&1 | tee -a $LOGFILE
echo "Gebruiker $gebr toevoeging afgerond." 2>&1 | tee -a $LOGFILE

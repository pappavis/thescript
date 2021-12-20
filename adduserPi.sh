_hn=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/adduserPi-`date +%Y-%m-%d_%Hh%Mm`.log
mkdir ~/logs
gebr="michiele"
wachtwoord="raspberry"

echo "* Nieuwe gebruiker wordt aangemaakt: $gebr"  2>&1 | tee -a $LOGFILE
sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/$gebr --gecos "User" $gebr
echo "$gebr:$wachtwoord" | sudo chpasswd


for addonnodes in dialout tty gpio i2c ; do
  echo "Gebruiker $gebr rechten toewijzen aan groep:  \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
  sudo usermod $gebr -g ${addonnodes}  2>&1 | tee -a $LOGFILE
done

sudo echo "$gebr ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$gebr
sudo chmod 0440 /etc/sudoers.d/$gebr
sudo chmod 4755 /usr/bin/sudo
printf "${ICyan}gebruiker $gebr aangemaakt, wachtwoord is \"$wachtwoord\". Afmelden en opnieuw aanmelden indien gewenst ${IWhite}\r\n\r\n"
sudo cp $(readlink -f) /home/$gebr && chown $gebr.$gebr -R /home/$gebr/ && chmod 755 /home/$gebr/
echo ""
echo "Gebruiker $gebr toevoeging afgerond." 2>&1 | tee -a $LOGFILE

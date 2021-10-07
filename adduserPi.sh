LOGFILE=~/logbestand1.txt
echo ""  >> $LOGFILE
echo "* Nieuwe gebruiker wordt aangemaakt: michiele"
sudo adduser --quiet --disabled-password --shell /bin/bash --home /home/michiele --gecos "User" michiele
echo "michiele:raspberry" | sudo chpasswd
sudo usermod michiele -g sudo -G ssh -a
sudo usermod michiele -g dialout
sudo usermod michiele -g tty
sudo usermod michiele -g gpio
sudo usermod michiele -g i2c


sudo echo "pi ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/michiele
sudo chmod 0440 /etc/sudoers.d/michiele
sudo chmod 4755 /usr/bin/sudo
printf "${ICyan}gebruiker PI aangemaakt, wachtwoord is \"raspberry\". Afmelden en opnieuw aanmelden indien gewenst ${IWhite}\r\n\r\n"
sudo cp $(readlink -f $0) /home/michiele && chown michiele.michiele /home/michiele/$0 && chmod 755 /home/michiele/$0
sudo chown michiele.michiele $LOGFILE && sudo chmod 644 $LOGFILE && sudo cp $LOGFILE /home/michiele
echo ""

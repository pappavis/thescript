echo "* Nieuwe gebruiker wordt aangemaakt: michiele"
adduser --quiet --disabled-password --shell /bin/bash --home /home/michiele --gecos "User" michiele
echo "michiele:raspberry" | chpasswd
usermod michiele -g sudo -G ssh -a
echo "pi ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/michiele
chmod 0440 /etc/sudoers.d/michiele
chmod 4755 /usr/bin/sudo
printf "${ICyan}gebruiker PI aangemaakt, wachtwoord is \"raspberry\". Afmelden en opnieuw aanmelden indien gewenst ${IWhite}\r\n\r\n"
cp $(readlink -f $0) /home/raspberry && chown michiele.michiele /home/michiele/$0 && chmod 755 /home/michiele/$0
chown michiele.michiele $LOGFILE && chmod 644 $LOGFILE && cp $LOGFILE /home/michiele
echo ""

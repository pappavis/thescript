       LOGFILE="/tmp/sqliteInstall1.log"
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

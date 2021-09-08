cd ~/Downloads
echo "Download en installeer virtualhere.com Pi 3 server & client"
wget https://www.virtualhere.com/sites/default/files/usbserver/vhusbdarmpi3
wget https://www.virtualhere.com/sites/default/files/usbclient/vhuitarm7
wget https://virtualhere.com/sites/default/files/usbserver/vhusbdarmpi
wget https://virtualhere.com/sites/default/files/usbserver/vhusbdx86_64
chmod +x ./vhusbdarmpi3
chmod +x ./vhuitarm7
chmod +x ./vhusbdarmpi
chmod +x ./vhusbdx86_64
sudo cp -r -v ./vhusbd* /usr/local/bin
sudo cp ./vhui* /usr/local/bin
echo "Start VirtualHerer Raspberry Pi server"
sudo vhusbdarmpi3 -b
sudo apt-get install -y phpmyadmin
sudo ln -s /usr/share/phpmyadmin /var/www/html
sudo apt install -y raspberrypi-ui-mods
echo "Je moet 'vhusbdarmpi3 -b' toevoegen aan /etc/rc.local. voor de exit 0 "

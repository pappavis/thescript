cd ~/Downloads
echo "Download en installeer virtualhere.com Pi 3 server & client"
wget https://www.virtualhere.com/sites/default/files/usbserver/vhusbdarmpi3
wget https://www.virtualhere.com/sites/default/files/usbclient/vhuitarm7
chmod +x ./vhusbdarmpi3
chmod +x ./vhuitarm7
sudo cp ./vhusbdarmpi3 /usr/local/bin
sudo cp ./vhuitarm7 /usr/local/bin
echo "Start VirtualHerer Raspberry Pi server"
sudo vhusbdarmpi3 -b 
echo "Je moet 'vhusbdarmpi3 -b' toevoegen aan /etc/rc.local. voor de exit 0 "

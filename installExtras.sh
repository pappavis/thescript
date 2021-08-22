cd ~/Downloads
echo "Download en installeer virtualhere.com Pi 3 sever & client"
wget https://www.virtualhere.com/sites/default/files/usbserver/vhusbdarmpi3
wget https://www.virtualhere.com/sites/default/files/usbclient/vhuitarm7
chmod +x ./vhusbdarmpi3
chmod +x ./vhuitarm7
sudo cp ./vhusbdarmpi3 /usr/local/bin
sudo cp ./vhuitarm7 /usr/local/bin
echo "Start VirtualHerer Raspberry Pi server"
vhusbdarmpi3 -b 

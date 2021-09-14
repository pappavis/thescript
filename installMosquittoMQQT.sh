MYMENU=$"nodenew"
OPSYS=${ID^^}
LOGFILE="~/pi_setup.log"
adminname="admin"
adminpass="rider506"

if [ 1==1 ]; then
	sudo apt install -y mosquitto mosquitto-clients 
        sudo bash -c "echo -e \"listener 9001\nprotocol websockets\nlistener 1883\nallow_anonymous false\npassword_file /etc/mosquitto/passwords\" > /etc/mosquitto/conf.d/websockets.conf"
        sudo touch /etc/mosquitto/passwords
        sudo mosquitto_passwd  -b /etc/mosquitto/passwords $adminname $adminpass


echo "alias mqttlog='tail -f /var/log/mosquitto/mosquitto.log | ccze -A'" | sudo tee -a /etc/bash.bashrc > /dev/null 2>&1


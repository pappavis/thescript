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

if [[ $OPSYS == *"RASPBIAN"* ]]; then
echo -e "[Unit]\n\
Description=Mosquitto MQTT Broker daemon\n\
ConditionPathExists=/etc/mosquitto/mosquitto.conf\n\
After=network.target\n\
Requires=network.target\n\
\n\
[Service]\n\
Type=forking\n\
RemainAfterExit=no\n\
StartLimitInterval=0\n\
PIDFile=/var/run/mosquitto.pid\n\
ExecStart=/usr/sbin/mosquitto -c /etc/mosquitto/mosquitto.conf -d\n\
ExecReload=/bin/kill -HUP $MAINPID\n\
Restart=on-failure\n\
RestartSec=2\n\
\n\
[Install]\n\
WantedBy=multi-user.target\n" | sudo tee /lib/systemd/system/mosquitto
			sudo systemctl  start mosquitto 2>&1 | tee -a $LOGFILE
			sudo systemctl enable mosquitto 2>&1 | tee -a $LOGFILE
fi
echo "alias mqttlog='tail -f /var/log/mosquitto/mosquitto.log | ccze -A'" | sudo tee -a /etc/bash.bashrc > /dev/null 2>&1


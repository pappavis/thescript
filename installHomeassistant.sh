_hn="http://"$(hostname).local":8123"
ehco "Installeren Homeassistant"
~/.local/bin/virtualenv ~/venv/homeassistant
source ~/venv/homeassistant/bin/activate
pip3 install homeassistant
sudo echo "source /home/pi/venv/homeassistant/bin/activate" >> /usr/local/bin/homeassistant
sudo chmod +x /usr/local/bin/homeassistant
sudo echo "/home/pi/venv/homeassistant/bin/hass" >> /usr/local/bin/homeassistant
pip install --upgrade pip homebridge
sudo echo "/home/pi/venv/homeassistant/bin/hass" >> /usr/local/bin/homeassistant
sudo echo "source /home/pi/venv/venv3.7/bin/activate"  >> /usr/local/bin/homeassistant
sudo echo "printf '\nStart homeassitant op http://". $_hn.local:8123\n'" . "  >> /usr/local/bin/homeassistant
printf "\nStart homeassistant op "
printf $_hn
printf "\n\nhomeassistant install afgerond\n"

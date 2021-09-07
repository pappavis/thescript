~/.local/bin/virtualenv ~/venv/homeassistant
source ~/venv/homeassistant/bin/activate
pip3 install homeassistant
sudo echo "source /home/pi/venv/homeassistant/bin/activate" >> /usr/local/bin/hass
sudo echo "/home/pi/venv/homeassistant/bin/hass" >> /usr/local/bin/hass
pip install --upgrade pip homebridge
sudo echo "/home/pi/venv/homeassistant/bin/hass" >> /usr/local/bin/hass
sudo echo "source /home/pi/venv/venv3.7/bin/activate"  >> /usr/local/bin/hass
sudo echo "printf 'Start homeassitant op http://dietpi.local:8123\n'"  >> /usr/local/bin/hass
sudo chmod +x /usr/local/bin/hass
printf "homeassistant install afgerond\n"

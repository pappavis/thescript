_hn="http://"$(hostname).local":8123"
_pwd=$(pwd)
echo "Installeren Homeassistant"
virtualenv ~/venv/homeassistant
source ~/venv/homeassistant/bin/activate
pip install --upgrade pip
pip install --upgrade homeassistant ffmpeg
sudo echo "source /home/pi/venv/homeassistant/bin/activate" >> /usr/local/bin/homeassistant
sudo chmod +x /usr/local/bin/homeassistant
sudo echo "/home/pi/venv/homeassistant/bin/hass" >> /usr/local/bin/homeassistant
recho "pip install --upgrade pip homebridge"

mkdir ~/Downloads
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/homeassistant.service
sudo mv ./homeassistant.service /etc/systemd/system
sudo systemctl enable homeassistant.service
sudo service homeassistant restart

sudo echo "/home/pi/venv/homeassistant/bin/hass" >> /usr/local/bin/homeassistant
sudo echo "source /home/pi/venv/venv3.7/bin/activate"  >> /usr/local/bin/homeassistant

cd $_pwd

printf "\nStart homeassitant op http://$_hn.local:8123\n"

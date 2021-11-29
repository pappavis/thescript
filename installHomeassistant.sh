_hn="http://"$(hostname).local":8123"
_pwd=$(pwd)
source /home/pi/.bashrc
echo "Installeren Homeassistant"
python3 -m virtualenv /home/pi/venv/homeassistant
source /home/pi/venv/homeassistant/bin/activate
pip install --upgrade pip
pip install --upgrade homeassistant
pip install --upgrade ffmpeg

mkdir ~/Downloads
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/homeassistant.service
sudo mv ./homeassistant.service /etc/systemd/system
sudo systemctl enable homeassistant.service
sudo service homeassistant restart

cd $_pwd

printf "\nStart homeassitant op http://$_hn.local:8123\n"
source ~/.bashrc

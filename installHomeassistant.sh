_hn=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installHomeassistant-`date +%Y-%m-%d_%Hh%Mm`.log
mkdir ~/logs

source /home/pi/.bashrc
echo "Installeren Homeassistant"

python3 -m ensurepip

python3 -m virtualenv /home/pi/venv/homeassistant
source /home/pi/venv/homeassistant/bin/activate

for addonnodes in  pip virtualenv homeassistant ffmpeg ; do
	echi "Installeren Homeassistant vereisten:  \"${addonnodes}\""
  pip install --upgrade ${addonnodes}  2>&1 | tee -a $LOGFILE
done


mkdir ~/Downloads
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/homeassistant.service
sudo mv ./homeassistant.service /etc/systemd/system
sudo systemctl enable homeassistant.service
sudo service homeassistant restart

cd $_pwd

printf "\nStart homeassitant op http://$_hn.local:8123\n"
source ~/.bashrc

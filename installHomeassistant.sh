_hn=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installHomeassistant-`date +%Y-%m-%d_%Hh%Mm`.log
mkdir ~/logs

source /home/pi/.bashrc
echo "Installeren Homeassistant" 2>&1

python3 -m ensurepip

python3 -m virtualenv /home/pi/venv/homeassistant
source /home/pi/venv/homeassistant/bin/activate

mkdir ~/Downloads
cd ~/Downloads
echo "1"  2>&1  | curl https://sh.rustup.rs -sSf | sh  2>&1 
source $HOME/.cargo/env

for addonnodes in  pip wheel ffmpeg homeassistant ; do
	echo "Installeren Homeassistant vereisten:  \"${addonnodes}\""
  	pip install --upgrade ${addonnodes}  2>&1 | tee -a $LOGFILE
done

sudo useradd -rm homeassistant -G dialout,gpio,i2c  2>&1 | tee -a $LOGFILE
sudo mkdir /home/homeassistant  2>&1 | tee -a $LOGFILE
sudo chown homeassistant:homeassistant /home/homeassistant  2>&1 | tee -a $LOGFILE

wget https://raw.githubusercontent.com/pappavis/thescript/master/services/homeassistant.service  2>&1 | tee -a $LOGFILE
sudo mv ./homeassistant.service /etc/systemd/system  2>&1 | tee -a $LOGFILE
sudo systemctl enable homeassistant.service  2>&1 | tee -a $LOGFILE
sudo service homeassistant restart  2>&1 | tee -a $LOGFILE

# install Sonoff POW R3
cp -v ./configuration.yaml ~/.homeassistant  2>&1 | tee -a $LOGFILE
cd ~/Downloads  2>&1 | tee -a $LOGFILE
git clone https://github.com/AlexxIT/SonoffLAN  2>&1 | tee -a $LOGFILE
mv -v ~/.homeassistant/SonoffLAN/custom_components/ ~/.homeassistant/ 2>&1 | tee -a $LOGFILE

sudo service homeassistant restart  2>&1 | tee -a $LOGFILE
sudo service homeassistant status  2>&1 | tee -a $LOGFILE

cd $_pwd

echo "\nStart homeassitant op http://$_hn.local:8123\n" 2>&1 | tee -a $LOGFILE
source ~/.bashrc

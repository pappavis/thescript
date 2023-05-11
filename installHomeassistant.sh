_hn=$(hostname)
_pwd=$(pwd)
LOGFILE=$HOME/logs/installHomeassistant-`date +%Y-%m-%d_%Hh%Mm`.log
mkdir ~/logs

source /home/pi/.bashrc
echo "Installeren Homeassistant" 2>&1

python3 -m ensurepip  2>&1 | tee -a $LOGFILE

python3 -m virtualenv /home/pi/venv/homeassistant  2>&1 | tee -a $LOGFILE
source /home/pi/venv/homeassistant/bin/activate

mkdir ~/Downloads
cd ~/Downloads
curl https://sh.rustup.rs -sSf | sh -s -- -y  2>&1 | tee -a $LOGFILE
source $HOME/.cargo/env

for addonnodes in  pip wheel ffmpeg homeassistant ; do
	echo "Installeren Homeassistant vereisten:  \"${addonnodes}\""
  	pip install --upgrade ${addonnodes}  2>&1 | tee -a $LOGFILE
done

sudo useradd -rm homeassistant -G dialout,gpio,i2c  2>&1 | tee -a $LOGFILE
sudo mkdir /home/homeassistant  2>&1 | tee -a $LOGFILE
sudo chown homeassistant:homeassistant /home/homeassistant  2>&1 | tee -a $LOGFILE

mkdir ~/.homeassistant
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/services/homeassistant.service  2>&1 | tee -a $LOGFILE
sudo mv ./homeassistant.service /etc/systemd/system  2>&1 | tee -a $LOGFILE
sudo systemctl enable homeassistant.service  2>&1 | tee -a $LOGFILE
sudo service homeassistant restart  2>&1 | tee -a $LOGFILE

# install Sonoff POW R3
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/configuration.yaml   2>&1 | tee -a $LOGFILE

mv -v ./configuration.yaml ~/.homeassistant  2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone https://github.com/AlexxIT/SonoffLAN  2>&1 | tee -a $LOGFILE
mv -v ~/Downloads/SonoffLAN/custom_components/ ~/.homeassistant/ 2>&1 | tee -a $LOGFILE
sudo rm -rf ~/Downloads/SonoffLAN/ 2>&1 | tee -a $LOGFILE

echo "[]" |  2>&1 | tee -a  ~/.homeassistant/automations.yaml
echo "" |  2>&1 | tee -a  ~/.homeassistant/scripts.yaml
echo "" |  2>&1 | tee -a  ~/.homeassistant/scenes.yaml

wget -O - https://get.hacs.xyz | bash -  2>&1 | tee -a $LOGFILE

sudo service homeassistant restart  2>&1 | tee -a $LOGFILE
sudo service homeassistant status  2>&1 | tee -a $LOGFILE

# 20230510 https://support.hoobs.org/docs/60e9f2ecdea381a881af7237
wget -qO- https://dl.hoobs.org/stable 2>&1  | sudo bash -   | tee -a $LOGFILE
for addonnodes in  hoobsd hoobs-cli hoobs-gui ; do
	echo "Installeren HOOBs als Homeassistant  alternatief:  \"${addonnodes}\""
  	sudo apt install -y ${addonnodes}  2>&1 | tee -a $LOGFILE
done
sudo hbs install  2>&1 | tee -a $LOGFILE &

cd $_pwd

echo "\nStart homeassitant op http://$_hn.local:8123\n" 2>&1 | tee -a $LOGFILE
source ~/.bashrc

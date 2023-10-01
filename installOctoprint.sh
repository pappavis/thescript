LOGFILE=$HOME/logs/installOctoprint-`date +%Y-%m-%d_%Hh%Mm`.log
_pwd=$(pwd)
_hn1=$(hostname)
mkdir $HOME/logs
echo "SETUP: Skep octoprint virtualenv." 2>&1 | tee -a $LOGFILE


for addonnodes in  python3-pip python3-virtualenv ; do
	echo "Installeren Octoprint python3 vereisten:  \"${addonnodes}\""
  	sudo apt install -y ${addonnodes}  2>&1 | tee -a $LOGFILE
done

mkdir ~/venv/ 2>&1 | tee -a $LOGFILE
/usr/bin/python3  -m pip install virtualenv 2>&1 | tee -a $LOGFILE
/usr/bin/python3 -m virtualenv ~/venv/oprint 2>&1 | tee -a $LOGFILE

echo "SETUP: Aktiveer oprint virtualenv."  2>&1 | tee -a $LOGFILE
source ~/venv/oprint/bin/activate

pip install --upgrade pip pipx 2>&1 | tee -a $LOGFILE
pipx ensurepip 2>&1 | tee -a $LOGFILE

for addonnodes in  pip octoprint ffmpeg ; do
	echo "Installeren Octoprint vereisten:  \"${addonnodes}\""
  	pip install ${addonnodes}  2>&1 | tee -a $LOGFILE
done


echo "SETUP: pi toegang naar devices."  2>&1 | tee -a $LOGFILE
sudo usermod -a -G tty pi &
sudo usermod -a -G dialout pi &

echo "SETUP: Installeer Octoprint als service."  2>&1 | tee -a $LOGFILE
mkdir ~/Downloads
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/services/octoprint.service  2>&1 | tee -a $LOGFILE
sudo mv ./octoprint.service /etc/systemd/system 2>&1 | tee -a $LOGFILE
sudo systemctl enable octoprint.service 2>&1 | tee -a $LOGFILE
sudo service octoprint restart 2>&1 | tee -a $LOGFILE
sudo service octoprint status 2>&1 | tee -a $LOGFILE

echo "Installeer Octoprint extenties." 2>&1 | tee -a $LOGFILE
bash $_pwd/installOctoprintPlugins.sh 2>&1 | tee -a $LOGFILE

printf "\nStart Octoprint service op http://$_hn1:5000\n" 2>&1 | tee -a $LOGFILE
sudo service octoprint restart
sudo service octoprint status 2>&1 | tee -a $LOGFILE
echo "Octoprint install afgerond.\n" 2>&1 | tee -a $LOGFILE
cd $_pwd

#sudo docker pull octoprint/octoprint:edge 2>&1 | tee -a $LOGFILE
#sudo docker run octoprint --device /dev/video0:/dev/video0 -e ENABLE_MJPG_STREAMER=true 
source ~/venv/venv/bin/activate | tee -a $LOGFILE
echo "einde octoprint install." 2>&1 | tee -a $LOGFILE


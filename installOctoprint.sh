LOGFILE=$HOME/logs/installOctoprint-`date +%Y-%m-%d_%Hh%Mm`.log
_pwd=$(pwd)
_hn1=$(hostname)
mkdir $HOME/logs
echo "SETUP: Skep octoprint virtualenv." 2>&1 | tee -a $LOGFILE
~/.local/bin/virtualenv ~/oprint  2>&1 | tee -a $LOGFILE
echo "SETUP: Aktiveer virtualenv."  2>&1 | tee -a $LOGFILE
source ~/oprint/bin/activate

echo "installeren octoprint Plugins" 2>&1 | tee -a $LOGFILE

for addonnodes in  pip octoprint ffmpeg ; do
	echo "Installeren Octoprint vereisten:  \"${addonnodes}\""
  	pip install --upgrade ${addonnodes}  2>&1 | tee -a $LOGFILE
done


echo "SETUP: pi toegang naar devices." | tee -a $LOGFILE
sudo usermod -a -G tty pi &
sudo usermod -a -G dialout pi &

echo "SETUP: Installeer Octoprint als service." | tee -a $LOGFILE
mkdir ~/Downloads
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/octoprint.service | tee -a $LOGFILE
sudo mv ./octoprint.service /etc/systemd/system 2>&1 | tee -a $LOGFILE
sudo systemctl enable octoprint.service 2>&1 | tee -a $LOGFILE
sudo service octoprint restart 2>&1 | tee -a $LOGFILE
sudo service octoprint status 2>&1 | tee -a $LOGFILE

echo "Installeer Octoprint extenties." 2>&1 | tee -a $LOGFILE
bash $_pwd/installOctoprintPlugins.sh 2>&1 | tee -a $LOGFILE

source ~/venv/venv/bin/activate | tee -a $LOGFILE
printf "\nStart Octoprint service op http://$_hn1:5000\n" 2>&1 | tee -a $LOGFILE
sudo service octoprint restart
sudo service octoprint status
printf "Octoprint install afgerond.\n" 2>&1 | tee -a $LOGFILE
cd $_pwd

#sudo docker pull octoprint/octoprint:edge 2>&1 | tee -a $LOGFILE
#sudo docker run octoprint --device /dev/video0:/dev/video0 -e ENABLE_MJPG_STREAMER=true 
echo "einde octoprint install." 2>&1 | tee -a $LOGFILE


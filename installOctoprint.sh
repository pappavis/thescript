LOGFILE=$HOME/logs/installOctoprint-`date +%Y-%m-%d_%Hh%Mm`.log
_pwd=$(pwd)
_hn1=$(hostname)
mkdir $HOME/logs
echo "SETUP: Skep octoprint virtualenv." | tee -a $LOGFILE
~/.local/bin/virtualenv ~/venv/octoprint | tee -a $LOGFILE
echo "SETUP: Aktiveer virtualenv." | tee -a $LOGFILE
source ~/venv/octoprint/bin/activate


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
sudo mv ./octoprint.service /etc/systemd/system
sudo systemctl enable octoprint.service | tee -a $LOGFILE
sudo service octoprint restart

echo "Installeer Octoprint extenties." | tee -a $LOGFILE


for addonnodes in   https://github.com/RomainOdeval/OctoPrint-CrealityTemperature/releases/latest/download/master.zip \
  https://github.com/electr0sheep/OctoPrint-Cr10_leveling/archive/master.zip \
   https://github.com/tpmullan/OctoPrint-DetailedProgress/archive/master.zip \
   https://github.com/amsbr/OctoPrint-EEprom-Marlin/archive/master.zip \
   https://github.com/Salandora/OctoPrint-FileManager/archive/master.zip \
   https://github.com/mic159/octoprint-grbl-plugin/archive/master.zip  \
   https://github.com/google/OctoPrint-LEDStripControl/archive/master.zip \
   https://github.com/OctoPrint/OctoPrint-MQTT/archive/master.zip \ 
   https://github.com/FormerLurker/Octolapse/archive/v0.4.0.zip \
   https://github.com/OllisGit/OctoPrint-DisplayLayerProgress/releases/latest/download/master.zip \
   https://github.com/iFrostizz/OctoPrint-EasyServo/archive/master.zip \
   https://github.com/Mechazawa/Emergency_stop_simplified/archive/master.zip \
   https://github.com/mikedmor/OctoPrint_MultiCam/archive/master.zip \
   https://github.com/jneilliii/OctoPrint-BLTouch/archive/master.zip \
   https://github.com/frenchie4111/complicated-octoprint/archive/master.zip \
   https://github.com/StefanCohen/OctoPrint-Dashboard/archive/master.zip \
   https://github.com/AlexVerrico/Octoprint-Display-ETA/archive/master.zip \
   https://github.com/jslay88/OctoPrint-Dropbox-Timelapse/archive/master.zip \
   https://github.com/agrif/OctoPrint-InfluxDB/archive/master.zip \
   https://github.com/jneilliii/OctoPrint-MQTTPublish/archive/master.zip \
   https://github.com/bchanudet/OctoPrint-Octorant/archive/master.zip \
   https://github.com/jneilliii/OctoPrint-Tasmota/archive/master.zip \
   https://github.com/adilinden-oss/octoprint-webcamstreamer/archive/master.zip \
   https://github.com/jneilliii/OctoPrint-YouTubeLive/archive/master.zip \
   https://github.com/ozgunawesome/OctoPrint-PCA9685LEDStripControl/archive/master.zip \
   https://github.com/marian42/octoprint-preheat/archive/master.zip \
   https://github.com/OctoPrint/OctoPrint-RequestSpinner/archive/master.zip \
   https://github.com/jneilliii/Octoprint-STLViewer/archive/master.zip \
   https://github.com/rlogiacco/UploadAnything/archive/master.zip \
   https://github.com/jneilliii/OctoPrint-PrusaSlicerThumbnails/archive/refs/tags/1.0.0.zip \
   https://github.com/jneilliii/OctoPrint-FloatingNavbar/archive/refs/tags/0.3.7.zip \
   https://github.com/tpmullan/OctoPrint-DetailedProgress/archive/refs/tags/0.2.7.zip \ 
   https://github.com/malnvenshorn/OctoPrint-WebcamTab/archive/master.zip  ; do
	echo "Installeren Octoprint uitbreiding:  \"${addonnodes}\""
  	pip install --upgrade --no-cache-dir ${addonnodes}  2>&1 | tee -a $LOGFILE
done

source ~/venv/venv3.7/bin/activate | tee -a $LOGFILE
printf "\nStart Octoprint service op http://$_hn1:5000\n" | tee -a $LOGFILE
sudo service octoprint restart
sudo service octoprint status
printf "Octoprint install afgerond.\n" | tee -a $LOGFILE
cd $_pwd

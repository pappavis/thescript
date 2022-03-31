LOGFILE=$HOME/logs/installOctoprintPlugins-`date +%Y-%m-%d_%Hh%Mm`.log
_pwd=$(pwd)
_hn1=$(hostname)
mkdir $HOME/logs
echo "SETUP: Skep octoprint plugins." 2>&1 | tee -a $LOGFILE
source ~/oprint/bin/activate

echo "Installeer Octoprint extenties." 2>&1 | tee -a $LOGFILE

for addonnodes in   https://github.com/RomainOdeval/OctoPrint-CrealityTemperature/releases/latest/download/master.zip   https://github.com/electr0sheep/OctoPrint-Cr10_leveling/archive/master.zip    https://github.com/tpmullan/OctoPrint-DetailedProgress/archive/master.zip    https://github.com/amsbr/OctoPrint-EEprom-Marlin/archive/master.zip   https://github.com/Salandora/OctoPrint-FileManager/archive/master.zip    https://github.com/mic159/octoprint-grbl-plugin/archive/master.zip     https://github.com/google/OctoPrint-LEDStripControl/archive/master.zip    https://github.com/OctoPrint/OctoPrint-MQTT/archive/master.zip    https://github.com/FormerLurker/Octolapse/archive/v0.4.0.zip    https://github.com/OllisGit/OctoPrint-DisplayLayerProgress/releases/latest/download/master.zip \
   https://github.com/iFrostizz/OctoPrint-EasyServo/archive/master.zip    https://github.com/Mechazawa/Emergency_stop_simplified/archive/master.zip    https://github.com/mikedmor/OctoPrint_MultiCam/archive/master.zip    https://github.com/jneilliii/OctoPrint-BLTouch/archive/master.zip    https://github.com/frenchie4111/complicated-octoprint/archive/master.zip    https://github.com/StefanCohen/OctoPrint-Dashboard/archive/master.zip    https://github.com/AlexVerrico/Octoprint-Display-ETA/archive/master.zip    https://github.com/jslay88/OctoPrint-Dropbox-Timelapse/archive/master.zip    https://github.com/agrif/OctoPrint-InfluxDB/archive/master.zip    https://github.com/jneilliii/OctoPrint-MQTTPublish/archive/master.zip    https://github.com/bchanudet/OctoPrint-Octorant/archive/master.zip    https://github.com/jneilliii/OctoPrint-Tasmota/archive/master.zip    https://github.com/adilinden-oss/octoprint-webcamstreamer/archive/master.zip    https://github.com/jneilliii/OctoPrint-YouTubeLive/archive/master.zip    https://github.com/ozgunawesome/OctoPrint-PCA9685LEDStripControl/archive/master.zip    https://github.com/marian42/octoprint-preheat/archive/master.zip    https://github.com/OctoPrint/OctoPrint-RequestSpinner/archive/master.zip    https://github.com/jneilliii/Octoprint-STLViewer/archive/master.zip    https://github.com/rlogiacco/UploadAnything/archive/master.zip \
   https://github.com/jneilliii/OctoPrint-PrusaSlicerThumbnails/archive/refs/tags/1.0.0.zip    https://github.com/jneilliii/OctoPrint-FloatingNavbar/archive/refs/tags/0.3.7.zip    https://github.com/tpmullan/OctoPrint-DetailedProgress/archive/refs/tags/0.2.7.zip     https://github.com/OllisGit/OctoPrint-DisplayLayerProgress/archive/refs/tags/1.28.0.zip    https://github.com/FormerLurker/Octolapse/archive/refs/tags/v0.4.1.zip    https://github.com/marian42/octoprint-preheat/archive/refs/tags/0.8.0.zip  \
   https://github.com/OctoPrint/OctoPrint-RequestSpinner/archive/refs/tags/0.2.0.zip    https://github.com/jneilliii/Octoprint-STLViewer/archive/refs/tags/0.4.2.zip    https://github.com/rlogiacco/UploadAnything/archive/master.zip    https://github.com/malnvenshorn/OctoPrint-WebcamTab/archive/master.zip  ; do
	echo "Installeren Octoprint uitbreiding:  \"${addonnodes}\""
  	pip install --upgrade --no-cache-dir ${addonnodes}  2>&1 | tee -a $LOGFILE
done

printf "Octoprint plugins install afgerond.\n" 2>&1 | tee -a $LOGFILE
cd $_pwd

#sudo docker pull octoprint/octoprint:edge 2>&1 | tee -a $LOGFILE
#sudo docker run octoprint --device /dev/video0:/dev/video0 -e ENABLE_MJPG_STREAMER=true 

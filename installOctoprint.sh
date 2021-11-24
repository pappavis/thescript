_pwd=$(pwd)
echo "SETUP: Skep octoprint virtualenv."
virtualenv ~/venv/octoprint
echo "SETUP: Aktiveer virtualenv."
source ~/venv/octoprint/bin/activate
pip install -- upgrade pip
pip install -- upgrade octoprint
pip install -- upgrade ffmpeg

echo "SETUP: pi toegang naar devices."
sudo usermod -a -G tty pi &
sudo usermod -a -G dialout pi &

echo "SETUP: Installeer als service."
mkdir ~/Downloads
cd ~/Downloads
wget https://raw.githubusercontent.com/pappavis/thescript/master/octoprint.service
sudo mv ./octoprint.service /etc/systemd/system
sudo systemctl enable octoprint.service
sudo service octoprint restart


##echo "DAEMON=/home/pi/venv/OctoPrint/venv/bin/octoprint" >> /etc/default/octoprint
##sudo update-rc.d octoprint defaults
##echo "SETUP: Start octoprint service."

echo "Installeer extenties."
pip --disable-pip-version-check install https://github.com/RomainOdeval/OctoPrint-CrealityTemperature/releases/latest/download/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/electr0sheep/OctoPrint-Cr10_leveling/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/tpmullan/OctoPrint-DetailedProgress/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/amsbr/OctoPrint-EEprom-Marlin/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/Salandora/OctoPrint-FileManager/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/mic159/octoprint-grbl-plugin/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/google/OctoPrint-LEDStripControl/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/OctoPrint/OctoPrint-MQTT/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/FormerLurker/Octolapse/archive/v0.4.0.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/OllisGit/OctoPrint-DisplayLayerProgress/releases/latest/download/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/iFrostizz/OctoPrint-EasyServo/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/Mechazawa/Emergency_stop_simplified/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/mikedmor/OctoPrint_MultiCam/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/jneilliii/OctoPrint-BLTouch/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/frenchie4111/complicated-octoprint/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/StefanCohen/OctoPrint-Dashboard/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/AlexVerrico/Octoprint-Display-ETA/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/jslay88/OctoPrint-Dropbox-Timelapse/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/agrif/OctoPrint-InfluxDB/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/jneilliii/OctoPrint-MQTTPublish/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/bchanudet/OctoPrint-Octorant/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/jneilliii/OctoPrint-Tasmota/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/adilinden-oss/octoprint-webcamstreamer/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/jneilliii/OctoPrint-YouTubeLive/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/ozgunawesome/OctoPrint-PCA9685LEDStripControl/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/marian42/octoprint-preheat/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/OctoPrint/OctoPrint-RequestSpinner/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/jneilliii/Octoprint-STLViewer/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/rlogiacco/UploadAnything/archive/master.zip --no-cache-dir
pip --disable-pip-version-check install https://github.com/malnvenshorn/OctoPrint-WebcamTab/archive/master.zip --no-cache-dir

source ~/venv/venv3.7/bin/activate
printf "\nStart Octoprint service op http://localhost:5000\n"
sudo service octoprint restart &
printf "Octoprint install afgerond.\n"
cd $_pwd

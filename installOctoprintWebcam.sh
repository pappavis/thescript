_pwd=$(pwd)
_hostname=$(hostname)
LOGFILE=$HOME/logs/installOctoprintWebcam-`date +%Y-%m-%d_%Hh%Mm`.log

echo "Installeren octoprint webcam build-essentials"
for addonnodes in subversion libjpeg62-turbo-dev imagemagick ffmpeg libv4l-dev cmake ; do
	echo "Installing octoprintWebcam lib: \"${addonnodes}\""
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

# https://blog.miguelgrinberg.com/post/how-to-build-and-run-mjpg-streamer-on-the-raspberry-pi
sudo ln -s /usr/include/linux/videodev2.h /usr/include/linux/videodev.h

echo "\nStart octprint webcam install op $_hostname\n" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone https://github.com/jacksonliam/mjpg-streamer.git 2>&1 | tee -a $LOGFILE
cd ~/Downloads/mjpg-streamer/mjpg-streamer-experimental
export LD_LIBRARY_PATH=.
make 2>&1 | tee -a $LOGFILE
sudo cp ./mjpg_streamer /usr/local/bin 2>&1 | tee -a $LOGFILE
sudo cp ./output_http.so input_file.so /usr/local/lib/ 2>&1 | tee -a $LOGFILE
sudo cp -R ./www /usr/local/www 2>&1 | tee -a $LOGFILE
rm -rf ~/Downloads/mjpg-streamer 2>&1 | tee -a $LOGFILE
mkdir /tmp/mjpg_stream 2>&1 | tee -a $LOGFILE
sudo usermod -aG video pi 2>&1 | tee -a $LOGFILE

webcamInfo=$(vcgencmd get_camera)

sudo raspi-gpio get 2>&1 | tee -a $LOGFILE 

echo "Webcam info: $webcamInfo" 2>&1 | tee -a $LOGFILE
echo "MJPG stream versie: $(mjpg_streamer -v)" 2>&1 | tee -a $LOGFILE

MJPGtestBestand="/temp/mjpg_stream/test_mjpg_streamer-`date +%Y-%m-%d_%Hh%Mm`.jpg"
echo "MJPG voorbeeld foto maken in  $MJPGtestBestand" 2>&1 | tee -a $LOGFILE

raspistill --nopreview -w 640 -h 480 -q 5 -o $MJPGtestBestand -tl 100 -t 9999999 -th 0:0:0 2>&1 | tee -a $LOGFILE &

echo "Octprint webcam streaming instellen: http://$_hostname.local:8080/?action=stream" 2>&1 | tee -a $LOGFILE
sudo service octoprint restart 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "installOctoprintWebcam is afgerond." 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

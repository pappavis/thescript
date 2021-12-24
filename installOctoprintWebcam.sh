_pwd=$(pwd)
_hostname=$(hostname)
LOGFILE=$HOME/logs/installOctoprintWebcam.log

echo "Installeren octoprint webcam build-essentials"
for addonnodes in subversion libjpeg62-turbo-dev imagemagick ffmpeg libv4l-dev cmake ; do
	echo "Installing octoprintWebcam lib: \"${addonnodes}\""
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done


echo "\nStart octprint webcam install op $_hostname\n" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone https://github.com/jacksonliam/mjpg-streamer.git 2>&1 | tee -a $LOGFILE
cd ~/Downloads/mjpg-streamer/mjpg-streamer-experimental
export LD_LIBRARY_PATH=.
make 2>&1 | tee -a $LOGFILE
echo "Octprint webcam streaming op http://$_hostname.local:8080/?action=stream" 2>&1 | tee -a $LOGFILE
./mjpg_streamer -i "./input_uvc.so -y" -o "./output_http.so" 
sudo service octoprint restart

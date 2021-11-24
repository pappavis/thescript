echo "\nStart octprint webcam install\n"
cd ~/Downloads
sudo apt install -y subversion libjpeg62-turbo-dev imagemagick ffmpeg libv4l-dev cmake
git clone https://github.com/jacksonliam/mjpg-streamer.git
cd ~/Downloads/mjpg-streamer/mjpg-streamer-experimental
export LD_LIBRARY_PATH=.
make
echo "\nOctprint webcam install gereed\n"
echo "\nOctprint webcam streaming op http://pivhere:8080/?action=stream\n"
./mjpg_streamer -i "./input_uvc.so -y" -o "./output_http.so" 
sudo service octoprint restart

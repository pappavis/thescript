#!/bin/bash
# http://cagewebdev.com/raspberry-pi-getting-audio-working/
LOGFILE=/home/pi/logs/installGeluid-`date +%Y-%m-%d_%Hh%Mm`.log
pwd1=(pwd)

echo "" 2>&1 | tee -a $LOGFILE
echo "$datum Start installGeluid" 2>&1 | tee -a $LOGFILE

for addonnodes in alsa-utils mpg321 lame libi2c-dev libgpiod-dev libasound2-dev libevent-dev ; do 
	echo ""  2>&1 | tee -a $LOGFILE
	echo "--Installeren geluid:  \"${addonnodes}\""  2>&1 | tee -a $LOGFILE
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo modprobe snd-bcm2835 2>&1 | tee -a $LOGFILE
sudo lsmod | grep 2835 2>&1 | tee -a $LOGFILE
i2cdetect 2>&1 | tee -a $LOGFILE
sudo amixer cset numid=2 2>&1 | tee -a $LOGFILE
aplay /usr/share/sounds/alsa/Front_Center.wav 2>&1 | tee -a $LOGFILE

echo "$datum installGeluid Haxophone Rust installeren installeren" 2>&1 | tee -a $LOGFILE
cd /home/pi
git clone https://github.com/cardonabits/haxo-rs
cd /home/pi/haxo-rs
cargo run
sudo cp -v ./target/debug/haxo001 /usr/local/bin

echo "$datum installGeluid Haxophone service installeren" 2>&1 | tee -a $LOGFILE
wget https://raw.githubusercontent.com/pappavis/thescript/master/services/haxophone.service  2>&1 | tee -a $LOGFILE
sudo cp -v ./services/haxophone.service /etc/systemd/system  2>&1 | tee -a $LOGFILE
sudo systemctl enable haxophone.service  2>&1 | tee -a $LOGFILE
sudo service haxophone restart  2>&1 | tee -a $LOGFILE

echo "$datum Einde installGeluid" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
cd /home/pi/Downloads/thescript

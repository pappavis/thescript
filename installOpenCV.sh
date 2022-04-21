#!/bin/bash
LOGFILE=$HOME/logs/installOpenCV-`date +%Y-%m-%d_%Hh%Mm`.log
_hn1=$(hostname)
_pwd=$(pwd)
mkdir $HOME/logs
echo "** OPTIONEEL!! Installeer OpenCV Python van broncode."  2>&1 | tee -a $LOGFILE
echo "sudo apt-get -y remove x264 libx264-dev"  2>&1 | tee -a $LOGFILE

echo "## Install OpenCV dependencies"  2>&1 | tee -a $LOGFILE
source ~/venv/venv/bin/activate
#python ./demo/opencv_pip_fix.py  2>&1 | tee -a $LOGFILE

sudo apt update -y

for addonnodes in git gfortran build-essential checkinstall cmake pkg-config yasm libjpeg8-dev libjasper-dev libpng12-dev libtiff5-dev libtiff-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine2-dev libv4l-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libgtk2.0-dev libtbb-dev qt5-default libatlas-base-dev libmp3lame-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev libopencore-amrnb-dev libopencore-amrwb-dev libavresample-dev x264 v4l-utils ; do
	echo "Installing OpenCV benodigheden \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

cd /usr/include/linux
sudo ln -s -f ../libv4l1-videodev.h videodev.h
cd $cwd

echo " Opencv Optional dependencies" 2>&1 | tee -a $LOGFILE
for addonnodes in python3-testresources libprotobuf-dev protobuf-compiler libgoogle-glog-dev libgflags-dev libgphoto2-dev libeigen3-dev libhdf5-dev doxygen ; do
	echo "Installing Opencv Optional dependencies \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

for addonnodes in pip setuptools numpy  dlib opencv-python==4.5.3.56 ; do
	echo "Installing Opencv python hulp \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	pip install --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo apt autoremove -y 2>&1 | tee -a $LOGFILE
sudo apt autoclean -y 2>&1 | tee -a $LOGFILE

echo " OpenCV install afgerond." 2>&1 | tee -a $LOGFILE

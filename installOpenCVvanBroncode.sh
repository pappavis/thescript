LOGFILE=$HOME/logs/installOpenCVvanBroncode-`date +%Y-%m-%d_%Hh%Mm`.log
_hn1=$(hostname)
_pwd=$(pwd)
mkdir $HOME/logs
PyVER=$(python -c "print(__import__('sys').version[:7].rstrip())")
OPENCVver=$'4.1.2'

echo "**Installeer OpenCV Python van broncode**"  2>&1 | tee -a $LOGFILE
echo "## Install OpenCV dependencies"  2>&1 | tee -a $LOGFILE

sudo apt update -y

for addonnodes in git gfortran build-essential checkinstall cmake pkg-config yasm libjpeg8-dev libjasper-dev libpng12-dev libtiff5-dev libtiff-dev libavcodec-dev libavformat-dev libswscale-dev libdc1394-22-dev libxine2-dev libv4l-dev libgstreamer0.10-dev libgstreamer-plugins-base0.10-dev libgtk2.0-dev libtbb-dev qt5-default libatlas-base-dev libmp3lame-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev libopencore-amrnb-dev libopencore-amrwb-dev libavresample-dev x264 v4l-utils ; do
	printstatus "Installing OpenCV benodigheden \"${addonnodes}\""
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

cd /usr/include/linux
sudo ln -s -f ../libv4l1-videodev.h videodev.h
cd $cwd

echo " Opencv Optional dependencies" 2>&1 | tee -a $LOGFILE
for addonnodes in python3-testresources libprotobuf-dev protobuf-compiler libgoogle-glog-dev libgflags-dev libgphoto2-dev libeigen3-dev libhdf5-dev doxygen ; do
	printstatus "Installing Opencv Optional dependencies \"${addonnodes}\""
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done


for addonnodes in  build-essential checkinstall yasm cmake git gfortran libgtk2.0-dev libgtk-3-dev pkg-config libavcodec-dev libavformat-dev libswscale-dev \
	libtbb2 libtbb-dev libjpeg-dev libpng-dev libtiff-dev jasper libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev \
	libxvidcore-dev libx264-dev libx265-dev libatlas-base-dev libwebp-dev cmake-curses-gui qtcreator  qt5-default sudo apt-get install \
	libgstreamer1.0-0 gstreamer1.0-plugins-base gstreamer1.0-plugins-good gstreamer1.0-plugins-bad gstreamer1.0-plugins-ugly gstreamer1.0-libav \
	gstreamer1.0-doc gstreamer1.0-tools gstreamer1.0-x gstreamer1.0-alsa gstreamer1.0-gl gstreamer1.0-gtk3 gstreamer1.0-qt5 gstreamer1.0-pulseaudio \
	libtiff5-dev libxine2-dev libfaac-dev libmp3lame-dev libtheora-dev libvorbis-dev libopencore-amrnb-dev libopencore-amrwb-dev libavresample-dev \
	x264 v4l-utils libprotobuf-dev protobuf-compiler libgoogle-glog-dev libgflags-dev libgphoto2-dev libeigen3-dev libhdf5-dev doxygen \
	libqt5x11extras5-dev qttools5-dev openexr libopenexr-dev libx11-dev libboost-python-dev ; do
	
	printstatus "Installeren Opencv afhanklijkheid \"${addonnodes}\""
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done

echo "Download opencv and opencv_contrib" 2>&1 | tee -a $LOGFILE
cd ~/Downloads/

rm -rf *$OPENCVver*.zip
wget https://github.com/opencv/opencv_contrib/archive/refs/tags/$OPENCVver.zip 2>&1 | tee -a $LOGFILE
mv ./$OPENCVver.zip ./opencv-$OPENCVver.zip
wget https://github.com/opencv/opencv/archive/refs/tags/$OPENCVver.zip 2>&1 | tee -a $LOGFILE
mv ./$OPENCVver.zip ./opencv_contrib-$OPENCVver.zip
tar -xf opencv-$OPENCVver.tar.gz 2>&1 | tee -a $LOGFILE
tar -xf opencv_contrib-$OPENCVver.tar.gz 2>&1 | tee -a $LOGFILE

pip install numpy

cd ./opencv-$OPENCVver/ 2>&1 | tee -a $LOGFILE
pip wheel . --verbose
mkdir build 2>&1 | tee -a $LOGFILE
cd build 2>&1 | tee -a $LOGFILE
ccmake .. 2>&1 | tee -a $LOGFILE

make -j$(nproc)  2>&1 | tee -a $LOGFILE
sudo make install 2>&1 | tee -a $LOGFILE


#cmake -D CMAKE_BUILD_TYPE=RELEASE \
#            -D CMAKE_INSTALL_PREFIX=$cwd/installation/OpenCV-"$cvVersion" \
#            -D INSTALL_C_EXAMPLES=ON \
#            -D INSTALL_PYTHON_EXAMPLES=ON \
#            -D WITH_TBB=ON \
#            -D WITH_V4L=ON \
#            -D OPENCV_PYTHON3_INSTALL_PATH=$cwd/OpenCV-$cvVersion-py3/lib/python$PyVER/site-packages \
#        -D WITH_QT=ON \
#        -D WITH_OPENGL=ON \
#        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
#        -D BUILD_EXAMPLES=ON .. 2>&1 | tee -a $LOGFILE
        
make -j$(nproc) 2>&1 | tee -a $LOGFILE
make install 2>&1 | tee -a $LOGFILE

echo " OpenCV build van bronkode afgerond." 2>&1 | tee -a $LOGFILE


LOGFILE=$HOME/logs/installOpenCV-`date +%Y-%m-%d_%Hh%Mm`.log
_hn1=$(hostname)
_pwd=$(pwd)
mkdir $HOME/logs
echo "** OPTIONEEL!! Installeer OpenCV Python van broncode."
echo "sudo apt-get -y remove x264 libx264-dev"

echo "## Install OpenCV dependencies"  2>&1 | tee -a $LOGFILE
source ~/venv/venv3.7/bin/activate
python ./demo/opencv_pip_fix.py  2>&1 | tee -a $LOGFILE

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

for addonnodes in pip numpy dlib ; do
	printstatus "Installing Opencv python hulp \"${addonnodes}\""
	pip install --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
done



exit 0




echo " Download opencv and opencv_contrib" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone https://github.com/opencv/opencv.git
cd opencv
git checkout 3.4
cd ..

git clone https://github.com/opencv/opencv_contrib.git
cd opencv_contrib
git checkout 3.4
cd .

cd opencv
mkdir build 2>&1 | tee -a $LOGFILE
cd build

cmake -D CMAKE_BUILD_TYPE=RELEASE \
            -D CMAKE_INSTALL_PREFIX=$cwd/installation/OpenCV-"$cvVersion" \
            -D INSTALL_C_EXAMPLES=ON \
            -D INSTALL_PYTHON_EXAMPLES=ON \
            -D WITH_TBB=ON \
            -D WITH_V4L=ON \
            -D OPENCV_PYTHON3_INSTALL_PATH=$cwd/OpenCV-$cvVersion-py3/lib/python3.5/site-packages \
        -D WITH_QT=ON \
        -D WITH_OPENGL=ON \
        -D OPENCV_EXTRA_MODULES_PATH=../../opencv_contrib/modules \
        -D BUILD_EXAMPLES=ON ..
        
make -j$(nproc)
make install

echo " OpenCV build van bronkode afgerond." 2>&1 | tee -a $LOGFILE
for addonnodes in pip setuptools wheel opencv-contrib-python roundface ; do
	printstatus "Installing Opencv python hulp \"${addonnodes}\""
	pip install --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
done

python ./demo/opencv_pip_fix.py
echo " OpenCV install afgerond." 2>&1 | tee -a $LOGFILE

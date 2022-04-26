LOGFILE=$HOME/logs/installTessarectOCR-`date +%Y-%m-%d_%Hh%Mm`.log
pwd=$(pwd)
echo "* Installeren Tessarect OCR"
sudo apt update -y

for addonnodes in g++ tesseract-ocr libtesseract-dev libgstreamer-plugins-base1.0-dev  libhdf5-dev libhdf5-serial-dev python3-pyqt5 libatlas-base-dev libjasper-dev   ; do
  echo " "
  echo " "
  echo "Installeren ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

_tv=$(tesseract --version)
echo "Tessarect $_tv is geïnstalleerd." 2>&1 | tee -a $LOGFILE

echo "Installeeren pre-built OpenCV... zie --> https://lindevs.com/install-precompiled-opencv-on-raspberry-pi/" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
wget https://github.com/prepkg/opencv-raspberrypi/releases/latest/download/opencv.deb 2>&1 | tee -a $LOGFILE
sudo apt install -y ./opencv.deb
cv2vers=$(opencv_version)
echo "Installeeren pre-built OpenCV $cv2vers voltooid." 2>&1 | tee -a $LOGFILE
rm -rf ./opencv.deb

source ~/venv/venv/bin/activate
cd $pwd

for addonnodes in pip setuptools wheel pytesseract libwebp6 libopencv-dev opencv-python   ; do
  echo " "
  echo " "
  echo "Installeren Python bieb: ${addonnodes}"
  echo " "
  pip install --upgrade  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo apt autoclean -y 2>&1 | tee -a $LOGFILE
sudo apt autoremove -y 2>&1 | tee -a $LOGFILE

python3 -c “import cv2; print(cv2.__version__)" 2>&1 | tee -a $LOGFILE
python ./demo/opencv_pip_fix.py 2>&1 | tee -a $LOGFILE

#pip install opencv-python &

echo "Tessarect $_tv  en OpenCV is installatie afgerond." 2>&1 | tee -a $LOGFILE

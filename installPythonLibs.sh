#!/bin/bash
LOGFILE=$HOME/logs/installPythonLibs-`date +%Y-%m-%d_%Hh%Mm`.log
_pwd=$(pwd)
mkdir $HOME/logs
echo '** Installeer pythonlibs. je moet eerst een virtualenv activeer!!'  2>&1 | tee -a $LOGFILE

#Array to store possible locations for temp read.
#python3 -m ensurepip 2>&1 | tee -a $LOGFILE
#python3 -m pip install virtualenv 2>&1 | tee -a $LOGFILE
#python3 -m virtualenv ~/venv/venv
source ~/venv/venv/bin/activate

sudo apt --fix-broken install -y
sudo apt install -y unixodbc-dev 2>&1 | tee -a $LOGFILE
sudo apt install -y python3-full 2>&1 | tee -a $LOGFILE

echo "PIP cache leeggooien." 2>&1 | tee -a $LOGFILE
rm -rf ~/.cache/pip 2>&1 | tee -a $LOGFILE

python3 -m pip install pipx 2>&1 | tee -a $LOGFILE

python -m ensurepip  2>&1 | tee -a $LOGFILE
rm -rf ~/.cache/pip 2>&1 | tee -a $LOGFILE

for addonnodes in  libatlas-base-dev libwebp-dev  python3-opencv wkhtmltopdf unixodbc-dev wiringpi i2c-tools ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren OpenCV vereisten: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    sudo apt install $NQUIET -y ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done

echo "Installeer voorvereisten van OpenCV" 2>&1 | tee -a $LOGFILE
for addonnodes in pytesseract numpy  ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren python pipx lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pipx install $NQUIET ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done


for addonnodes in pip setuptools wheel scikit-build numpy ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren python build tools python apps: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install --upgrade $NQUIET ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done

for addonnodes in pip setuptools wheel openpyxl pylzma py7zr o365 ttn qrcode pillow sqlalchemy sqlalchemy-access pymsteams qscintilla esptool adafruit-ampy firebirdsql   \
                  pyserial pyparsing pyzmail redmail gpiozero pytube pipx serial jinja2 esptool mpfshell virtualenv ffmpeg  jupyter-notebook \
                  scikit-build pygame pymongo psycopg2-binary mysql-connector-python guizero imutils scikit-image bokeh django flask pygrabber paho-mqtt \
                  msteamsconnector matplotlib numpy imutils pyodbc influxdb pysmb libopencv-dev opencv-python  git+https://github.com/pytube/pytube picamera djitellopy \
		   osxphotos RPi.GPIO tox PySimpleGUI libusb pyusb pdfkit python-dateutil pymysql python-vkontakte easyocr pygrabber \
		   imutils psycopg2 postgres firebirdsql html2pdf open3d face-recognition pyftdi psycopg2 asyncio pyshorteners picamera  homekit  pyaudio \ 
		   tk-tools pyqt5 aspose-words Office365-REST-Python-Client  pyresidfp googlemaps discotool  \
     		   soundcard pandas streamlit PyPDF2 g4f ; do

    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren python lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
    #conda install --upgrade --no-cache-dir  ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done


for addonnodes in tflite tflite-runtime tflite_support seaborn  git+https://github.com/rcmalli/keras-vggface.git keras keras-utils keras_vggface  Keras-Applications  mathplot  mtcnn  scikit-learn  spyder  theano ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren Tensorflow python lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
    #conda install --upgrade --no-cache-dir  ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done


for addonnodes in setuptools wheel scikit-build cmake mu-editor shortcut esptool numpy  pygrabber ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "PIPX.. alleen voor python apps: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done

# muziek en Midi
for addonnodes in fluidsynth upiano midisynth ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Install muziek python apps: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done


echo "Installeer voorvereisten van html2pdf" 2>&1 | tee -a $LOGFILE
for addonnodes in xvfb xfonts-100dpi xfonts-75dpi xfonts-scalable xfonts-cyrillic wkhtmltopdf easyeda2kicad ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren html2pdf lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done
pip install html2pdf

# 20221019 conda moet je handmatig installeren, want het toont een input prompt.  Deze script is bedoeld om  headless uitgevoerd te worden. 
#echo "Installeren Miniconda" 2>&1 | tee -a $LOGFILE
#cd ~/Downloads
#wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-armv7l.sh 2>&1 | tee -a $LOGFILE
#sudo bash ./Miniconda3-latest-Linux-armv7l.sh 2>&1 | tee -a $LOGFILE
#echo 'export PATH=/home/pi/miniconda3/bin:$PATH' | tee -a ~/.bashrc  2>&1 | tee -a $LOGFILE
#conda install python=3.11
#rm -rf ~/Downloads/Miniconda3*

echo "Installeren machine learning onderdelen." 2>&1 | tee -a $LOGFILE
for addonnodes in  torch torchvision torchaudio cudatoolkit ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren ML python lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
done

echo "doen ook --> pip uninstall serial" 2>&1 | tee -a $LOGFILE

echo  "Installeer Dataplicity.com" 2>&1 | tee -a $LOGFILE
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python3 2>&1 | tee -a $LOGFILE

cd $_pwd

pipx install conda  2>&1 | tee -a $LOGFILE
pip install --upgrade RPi.GPIO  2>&1 | tee -a $LOGFILE &
pip uninstall --no-input serial  2>&1 | tee -a $LOGFILE
  
echo "deb [signed-by=/usr/share/keyrings/coral-edgetpu-archive-keyring.gpg] https://packages.cloud.google.com/apt coral-edgetpu-stable main" | sudo tee /etc/apt/sources.list.d/coral-edgetpu.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/coral-edgetpu-archive-keyring.gpg >/dev/null 2>&1 | tee -a $LOGFILE
sudo apt update -y  2>&1 | tee -a $LOGFILE
#sudo apt install -y python3-tflite-runtime  2>&1 | tee -a $LOGFILE
echo "Installeren Tensorflow lite" 2>&1 | tee -a $LOGFILE
for addonnodes in  tflite tflite-runtime tflite_support tensorflow_datasets seaborn   ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren tensorflow python lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
    #conda install --upgrade --no-cache-dir  ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
 done
mkdir ~/Downloads/tf_voorbeeld
cd ~/Downloads/tf_voorbeeld
git clone https://github.com/tensorflow/examples --depth 1
cd ./examples/lite/examples/image_classification/raspberry_pi
sudo chmod +x setup.sh
./setup.sh
python ./classify.py
echo "Tensorflow lite install afgerond" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE



cd ~/Downloads
echo "Installeren Miniconda" 2>&1 | tee -a $LOGFILE
for addonnodes in  apt-transport-https ca-certificates software-properties-common ; do 
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren Miniconda docker vereisten: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    sudo apt install $NQUIET -y ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
done

mkdir ~/Programmering/
mkdir ~/Programmering/python
mkdir ~/Programmering/python/micropython
mkdir ~/Programmering/python/python        
mkdir ~/Programmering/python/python/uitprobeersels
mkdir ~/Programmering/python/python/project       
mkdir ~/Programmering/python/python/voorbeeld

#echo "Om OpenCV te gebruiken Deze commando op een pi4.." 2>&1 | tee -a $LOGFILE
#echo "LD_PRELOAD=/usr/lib/arm-linux-gnueabihf/libatomic.so.1.2.0 python3 Object_detection_picamera.py  --usbcam"  2>&1 | sudo tee -a /home/pi/.bashrc

# Homeassistant is afhanklijk van Rust
echo "1" | curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh


echo "" 2>&1 | tee -a $LOGFILE
echo "installPythonLibs.sh is afgerond"  2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

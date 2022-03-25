#!/bin/bash
echo '** Installeer pythonlibs. je moet eerst een virtualenv activeer!!' 
LOGFILE=$HOME/logs/installPythonLibs-`date +%Y-%m-%d_%Hh%Mm`.log
_pwd=$(pwd)
mkdir $HOME/logs

#Array to store possible locations for temp read.
#python3 -m ensurepip 2>&1 | tee -a $LOGFILE
#python3 -m pip install virtualenv 2>&1 | tee -a $LOGFILE
#~/.local/bin/virtualenv ~/venv/venv3.7/
#source ~/venv/venv3.7/bin/activate

sudo apt --fix-broken install -y
sudo apt install -y unixodbc-dev 2>&1 | tee -a $LOGFILE

echo "PIP cache leeggooien." 2>&1 | tee -a $LOGFILE
rm -rf ~/.cache/pip 2>&1 | tee -a $LOGFILE


for addonnodes in  unixodbc-dev wiringpi i2c-tools; do
    printstatus "Installeren: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
done

python -m ensurepip  2>&1 | tee -a $LOGFILE

for addonnodes in  libatlas-base-dev libwebp-dev  python3-opencv wkhtmltopdf  ; do
    printstatus "Installeren OpenCV vereisten: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    sudo apt install $NQUIET -y ${addonnodes} 2>&1 | tee -a $LOGFILE
  done

for addonnodes in pip setuptools wheel openpyxl pylzma py7zr o365 ttn qrcode pillow sqlalchemy pymsteams esptool adafruit-ampy firebirdsql esptool mu-editor shortcut \
                  pyserial pyparsing pyzmail redmail gpiozero pytube pipx serial jinja2 esptool mpfshell virtualenv ffmpeg conda jupyter-notebook \
                  scikit-build pygame pymongo psycopg2-binary mysql-connector-python guizero imutils scikit-image numpy bokeh django flask \
                  msteamsconnector matplotlib numpy imutils pyodbc influxdb pysmb opencv-contrib-python==3.4.11.45  git+https://github.com/pytube/pytube picamera djitellopy \
		   osxphotos RPi.GPIO tox tflite tflite-runtime tflite_support PySimpleGUI libusb pyusb pdfkit python-dateutil libopencv-dev  ; do
    printstatus "Installeren python lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
    conda install  ${addonnodes} 2>&1 | tee -a $LOGFILE
  done

shortcut mu-editor

echo "Installeren Miniconda" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
wget http://repo.continuum.io/miniconda/Miniconda3-latest-Linux-armv7l.sh 2>&1 | tee -a $LOGFILE
bash ./Miniconda3-latest-Linux-armv7l.sh 2>&1 | tee -a $LOGFILE
echo 'export PATH=/home/pi/miniconda3/bin:$PATH' | tee -a ~/.bashrc  2>&1 | tee -a $LOGFILE
conda install python=3.11

echo "Installeren machine learning onderdelen." 2>&1 | tee -a $LOGFILE
for addonnodes in  pytorch torchvision torchaudio cudatoolkit pytorch ; do
    printstatus "Installeren ML python lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
done

echo "doen ook --> pip uninstall serial" 2>&1 | tee -a $LOGFILE

printstatus  "Installeer Dataplicity.com" 2>&1 | tee -a $LOGFILE
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python 2>&1 | tee -a $LOGFILE

cd $_pwd

pipx install conda  2>&1 | tee -a $LOGFILE
pip install --upgrade RPi.GPIO  2>&1 | tee -a $LOGFILE &
pip uninstall --no-input serial  2>&1 | tee -a $LOGFILE

cd ~/Downloads
echo "Installeren Tensorflow lite" 2>&1 | tee -a $LOGFILE
echo "deb [signed-by=/usr/share/keyrings/coral-edgetpu-archive-keyring.gpg] https://packages.cloud.google.com/apt coral-edgetpu-stable main" | sudo tee /etc/apt/sources.list.d/coral-edgetpu.list
curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo tee /usr/share/keyrings/coral-edgetpu-archive-keyring.gpg >/dev/null
sudo apt update -y  2>&1 | tee -a $LOGFILE
# sudo apt install -y python3-tflite-runtime  2>&1 | tee -a $LOGFILE
echo "Tensorflow lite install afgerond" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

cd ~/Downloads
echo "Installeren Miniconda" 2>&1 | tee -a $LOGFILE
for addonnodes in  apt-transport-https ca-certificates software-properties-common ; do 
    printstatus "Installeren Miniconda docker vereisten: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    sudo apt install $NQUIET -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done


printstatus "installPythonLibs.sh is afgerond"  2>&1 | tee -a $LOGFILE

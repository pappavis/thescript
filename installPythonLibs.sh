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

sudo apt install -y unixodbc-dev 2>&1 | tee -a $LOGFILE

for addonnodes in  unixodbc-dev wiringpi i2c-tools; do
    printstatus "Installeren: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
done

python -m ensurepip  2>&1 | tee -a $LOGFILE

for addonnodes in  libatlas-base-dev libwebp-dev  python3-opencv  ; do
    printstatus "Installeren OpenCV vereisten: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    sudo apt install $NQUIET -y ${addonnodes} 2>&1 | tee -a $LOGFILE
  done

for addonnodes in pip setuptools wheel openpyxl py7zr o365 ttn qrcode pillow sqlalchemy pymsteams esptool adafruit-ampy firebirdsql esptool \
                  pyserial pyparsing pyzmail redmail gpiozero pytube pipx serial jinja2 esptool mpfshell virtualenv ffmpeg conda \
                  scikit-build pygame pymongo psycopg2-binary mysql-connector-python guizero imutils scikit-image numpy bokeh django flask \
                  msteamsconnector matplotlib numpy imutils pyodbc pysmb  opencv-contrib-python git+https://github.com/pytube/pytube picamera djitellopy \
		   osxphotos RPi.GPIO tox  ; do
    printstatus "Installeren python lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
  done

echo "doen ook --> pip uninstall serial" 2>&1 | tee -a $LOGFILE

printstatus  "Installeer Dataplicity.com" 2>&1 | tee -a $LOGFILE
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python 2>&1 | tee -a $LOGFILE

cd $_pwd

pipx install conda  2>&1 | tee -a $LOGFILE
pip install --upgrade RPi.GPIO  2>&1 | tee -a $LOGFILE &
pip uninstall --no-input serial  2>&1 | tee -a $LOGFILE

printstatus "installPythonLibs.sh is afgerond"  2>&1 | tee -a $LOGFILE

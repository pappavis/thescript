echo "** Installeer pythonlibs. je moet eerst een virtualenv activeer!!"

sudo apt install -y wiringpi 
sudo apt install -y rpi.gpio

python3 -m ensurepip
pip install openpyxl o365 ttn qrcode pillow sqlalchemy pymsteams esptool adafruit-ampy pyserial pyparsing pyzmail gpiozero pytube djitellopy pipx serial
pip install picamera opencv-contrib-python
pip install  scikit-build pygame
pip install pi.gpio
python3 -m pip install git+https://github.com/pytube/pytube

sudo apt install -y pyodbc
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python

echo "** Installeer pythonlibs. je moet eerst een virtualenv activeer!!"


source ~/venv/venv3.7/bin/activate

sudo apt install -y wiringpi 
sudo apt install -y rpi.gpio

python -m ensurepip
pip install --upgrade openpyxl o365 ttn qrcode pillow sqlalchemy pymsteams esptool adafruit-ampy pyserial pyparsing pyzmail gpiozero pytube djitellopy pipx serial jinja2
pip install --upgrade picamera opencv-contrib-python
pip install --upgrade scikit-build pygame
pip install --upgrade pi.gpio
pip install --upgrade matplotlib numpy
python3 -m pip install git+https://github.com/pytube/pytube

sudo apt install -y pyodbc
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python

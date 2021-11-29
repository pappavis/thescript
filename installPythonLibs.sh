echo '** Installeer pythonlibs. je moet eerst een virtualenv activeer!!' 


source ~/venv/venv3.7/bin/activate

sudo apt install -y wiringpi 
sudo apt install -y rpi.gpio

python -m ensurepip 
pip install --upgrade openpyxl o365 ttn qrcode pillow sqlalchemy pymsteams esptool adafruit-ampy 
pip install --upgrade pyserial pyparsing pyzmail gpiozero pytube 
pip install --upgrade pipx serial jinja2 esptool mpfshell virtualenv ffmpeg
pip install --upgrade scikit-build pygame pymongo psycopg2-binary mysql-connector-python guizero
pip install --upgrade rpi.gpio
pip install --upgrade matplotlib numpy imutils
python3 -m pip install git+https://github.com/pytube/pytube
echo "doen ook --> pip uninstall serial"

pip install --upgrade pyodbc
curl -s https://www.dataplicity.com/jfjro6ak.py | sudo python
pip install --upgrade pip setuptools wheel
sudo apt install -y python3-opencv

echo "pip install opencv-python-headless==4.4.0.44"
echo "pip install --upgrade djitellopy"
ehco "pip install --upgrade osxphotos"

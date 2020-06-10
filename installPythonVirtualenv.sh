#/usr/bin/sh
echo "Installeer nieuwe python3 virtuale omgeving"
sudo usermod -aG gpio pi
sudo usermod -aG dialout pi
sudo usermod -aG i2c pi
sudo usermod -aG tty pi

sudo apt install -y python3-pip python3-venv
#python3 -m pip install --user pipx
#python3 -m pipx ensurepath

python3 -m pip install virtualenv
mkdir ~/venv
python3 -m virtualenv ~/venv/venv3.7
source ~/venv/venv3.7/bin/activate
python3 -m pip install adafruit-blinka RPI.GPIO
echo "source ~/venv/venv3.7/bin/activate" >> ~/.bashrc
source ~/.bashrc

python3 -m pip install openpyxl pyzmail o365 ttn qrcode pillow sqlalchemy pymsteams
python3 -m pip install picamera opencv-contrib-python

sudo apt install -y tesseract-ocr libtesseract-dev libatlas3-base libqtcore4 -y
python3 -m pip install pytesseract opencv-contrib-python libwebp6
tesseract --version
sudo apt install -y imagemagick



#/usr/bin/sh
echo "Installeer nieuwe python3 virtuale omgeving"
sudo usermod -aG gpio pi
sudo usermod -aG dialout pi sudo usermod -aG i2c pi
sudo usermod -aG tty pi
sudo usermod -aG dialout pi


#python3 -m pip install --user pipx
#python3 -m pipx ensurepath
python3 -m pip install virtualenv
mkdir ~/venv
~/.local/bin/virtualenv ~/venv/venv3.7
echo "source ~/venv/venv3.7" >> ~/.bashrc
source ~/.bashrc

pip install openpyxl pyzmail o365 ttn qrcode pillow pyodbc sqlalchemy pymsteams
pip3 install picamera opencv-contrib-python libwebp6

sudo apt install -y tesseract-ocr libtesseract-dev libatlas3-base libqtcore4 -y
pip install pytesseract opencv-contrib-python libwebp6
tesseract --version
sudo apt install -y imagemagick



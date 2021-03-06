#/usr/bin/sh
echo "Installeer nieuwe python3 virtuale omgeving"
sudo usermod -aG gpio pi
sudo usermod -aG dialout pi
sudo usermod -aG i2c pi
sudo usermod -aG tty pi

sudo apt install -y python3-pip python3-venv
python3 -m pip install --user pipx pipenv
python3 -m pipx ensurepath
echo "source ~/.bashrc" >> ~/.bash_profile

#python3 -m pip install virtualenv
mkdir ~/venv
cd ~/venv
~/.local/bin/pipx install virtualenv
~/.local/bin/virtualenv ~/venv/venv3.7
source ~/venv/venv3.7/bin/activate
pip3.7 install adafruit-blinka RPI.GPIO
echo "source ~/venv/venv3.7/bin/activate" >> ~/.bashrc
source ~/.bashrc

pip3.7 install openpyxl o365 ttn qrcode pillow sqlalchemy pymsteams esptool adafruit-ampy pyserial pyparsing
easy_install pyzmail
pip3.7 install picamera opencv-contrib-python
pip3.7 install  scikit-build
easy_install pygamer

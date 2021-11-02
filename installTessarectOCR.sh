sudo apt install -y tesseract-ocr libtesseract-dev libatlas3-base libqtcore4 -y
tesseract --version
sudo apt update -y
sudo apt install -y imagemagick 
sudo apt install -y libfontconfig1-dev libcairo2-dev
sudo apt install -y libgdk-pixbuf2.0-dev libpango1.0-dev
sudo apt install -y libgtk2.0-dev libgtk-3-dev
sudo apt install -y libatlas-base-dev gfortran

source ~/venv/venv3.7/bin/activate
pip install --upgrade pytesseract 
pip install --upgrade opencv-contrib-python 
pip install --upgrade libwebp6

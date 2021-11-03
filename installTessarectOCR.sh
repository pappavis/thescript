sudo apt install -y tesseract-ocr libtesseract-dev libatlas3-base libqtcore4 -y
tesseract --version
sudo apt update -y
sudo apt install -y imagemagick 
sudo apt install -y libfontconfig1-dev libcairo2-dev
sudo apt install -y libgdk-pixbuf2.0-dev libpango1.0-dev
sudo apt install -y libgtk2.0-dev libgtk-3-dev
sudo apt install -y libatlas-base-dev gfortran python3-opencv
sudo apt install -y python3-opencv

python ./demo/opencv_pip_fix.py

source ~/venv/venv3.7/bin/activate
pip install --upgrade pip setuptools wheel
pip install --upgrade pytesseract 
pip install opencv-python-headless==4.4.0.44
pip install --upgrade libwebp6
python ./demo/opencv_pip_fix.py

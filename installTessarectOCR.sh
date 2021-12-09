LOGFILE=$HOME/$0-`date +%Y-%m-%d_%Hh%Mm`.log

echo "* Installeren Tessarect OCR"
sudo apt update -y

for addonnodes in tesseract-ocr libtesseract-dev libatlas3-base qtchooser imagemagick libfontconfig1-dev libcairo2-dev libgdk-pixbuf2.0-dev libpango1.0-dev libgtk2.0-dev libgtk-3-dev libatlas-base-dev gfortran python3-opencv  ; do
  echo "Installeren ${addonnodes}"
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

_tv=$(tesseract --version)

python ./demo/opencv_pip_fix.py

echo "Tessarect $_tv is geïnstalleerd."

source ~/venv/venv3.7/bin/activate
pip install --upgrade pip setuptools wheel
pip install --upgrade pytesseract 
pip install --upgrade libwebp6
pip install opencv-python-headless==4.4.0.44 &
python ./demo/opencv_pip_fix.py
sudo apt autoclean -y
sudo apt autoremove -y

echo "Tessarect $_tv  en OpenCV is installatie afgerond."

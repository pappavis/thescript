LOGFILE=$HOME/$0-`date +%Y-%m-%d_%Hh%Mm`.log

echo "* Installeren Tessarect OCR"
sudo apt update -y

for addonnodes in tesseract-ocr libtesseract-dev libatlas3-base qtchooser imagemagick libfontconfig1-dev libcairo2-dev libgdk-pixbuf2.0-dev libpango1.0-dev libgtk2.0-dev libgtk-3-dev libatlas-base-dev gfortran python3-opencv  ; do
  echo " "
  echo " "
  echo "Installeren ${addonnodes}"
  echo " "
  sudo apt install -y  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

_tv=$(tesseract --version)

python ./demo/opencv_pip_fix.py

echo "Tessarect $_tv is geïnstalleerd."

source ~/venv/venv3.7/bin/activate

for addonnodes in pip setuptools wheel pytesseract libwebp6 opencv-python-headless ; do
  echo " "
  echo " "
  echo "Installeren Python bieb: ${addonnodes}"
  echo " "
  pip install --upgrade  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

python ./demo/opencv_pip_fix.py
sudo apt autoclean -y
sudo apt autoremove -y

echo "Tessarect $_tv  en OpenCV is installatie afgerond."

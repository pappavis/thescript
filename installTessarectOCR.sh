LOGFILE=$HOME/logs/installTessarectOCR-`date +%Y-%m-%d_%Hh%Mm`.log

echo "* Installeren Tessarect OCR"
sudo apt update -y


for addonnodes in tesseract-ocr libtesseract-dev    ; do
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

for addonnodes in pip setuptools wheel pytesseract libwebp6 libopencv-dev opencv-python ; do
  echo " "
  echo " "
  echo "Installeren Python bieb: ${addonnodes}"
  echo " "
  pip install --upgrade  ${addonnodes} 2>&1 | tee -a $LOGFILE
done

sudo apt autoclean -y 2>&1 | tee -a $LOGFILE
sudo apt autoremove -y 2>&1 | tee -a $LOGFILE

python3 -c “import cv2; print(cv2.__version__)" 2>&1 | tee -a $LOGFILE
python ./demo/opencv_pip_fix.py 2>&1 | tee -a $LOGFILE

#pip install opencv-python &

echo "Tessarect $_tv  en OpenCV is installatie afgerond."

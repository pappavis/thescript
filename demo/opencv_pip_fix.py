# ref--> https://stackoverflow.com/questions/51853018/how-do-i-install-opencv-using-pip
from pip._internal import main as install
try:
    import cv2
except ImportError as e:
    install(["install", "opencv-python"])
finally:
    pass

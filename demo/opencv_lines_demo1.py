from ast import expr_context
from traceback import print_tb
import traceback
import cv2
import os
from pathlib import PurePath
import random
import numpy as np
import time

# penCV Python Tutorial #4 - Drawing (Lines, Images, Circles & Text)
#ref --> https://youtu.be/bPSfyK_DJAg?list=PLzMcBGfZo4-lUA8uGjeXhBUUzPYc6vZRn&t=41

class clsMain:
    def __init__(self) -> None:
        self.img = None
        self.cap = None
        self.scriptFull = PurePath(__file__)
        self.scriptPath = str(PurePath(self.scriptFull.parent))

    def main(self):
        plaatjeSrc = f'''{self.scriptPath}/assets/fles_Smirnoff1_20220315.jpg'''
        try:
            self.img = cv2.imread(plaatjeSrc, cv2.IMREAD_COLOR)
            cv2.imshow(f'''plaatje''', self.img)
            cv2.waitKey(2000)
            cv2.destroyAllWindows()
        except Exception as ex1:
            print(ex1)

        self.cap = cv2.VideoCapture(0)  #webcam 0
        try:
            maxTel = 300

            for tel1 in range(0,maxTel):
                ret1, frame1 = self.cap.read()        
                frameWidth = int(self.cap.get(cv2.CAP_PROP_FRAME_WIDTH))
                frameHeight = int(self.cap.get(cv2.CAP_PROP_FRAME_HEIGHT))

                #lijn teken
                self.img = cv2.line(img=frame1, pt1=(0,0), pt2=(frameWidth, frameHeight),color=(255,0,0) ,thickness=10)   #maak een leeg versie van de scherm vastlegging
                self.img = cv2.line(img=self.img, pt1=(0, frameHeight), pt2=(frameWidth, 0),color=(0,255,0) ,thickness=10)   #maak een leeg versie van de scherm vastlegging
                self.img = cv2.rectangle(img=self.img, pt1=(100,100), pt2=(200,200), color=(255,23,33), thickness=5)
                self.img = cv2.circle(img=self.img, center=(300,300), radius=60, color=(255,0,33), thickness=5)

                halloTekst1 = f"Test python OpenCV Easylab4Kids"
                self.img = cv2.putText(img=self.img, text=halloTekst1, org=(10, frameHeight - 10), fontFace=cv2.FONT_HERSHEY_SIMPLEX, fontScale=1, color=(0,0,255), thickness=2, lineType=cv2.LINE_AA)

                try:
                    cv2.imshow(f'''plaatje''', self.img)
                except Exception as ex3:
                    print(ex3)
                    
                if cv2.waitKey(1) == ord('q') or tel1 >= maxTel:
                    break

                print(f'''{tel1} van {maxTel}''')

            cv2.imwrite(f'''{self.scriptPath}/assets/tutorial4_webcamfoto1.jpg''', self.img)
            
        except Exception as ex1:
            print(traceback.print_exc())
        finally:
            cv2.destroyAllWindows()
            self.cap.release()



if __name__ == "__main__":
    print("App start")
    main1 = clsMain()
    main1.main()
    print("App eind")

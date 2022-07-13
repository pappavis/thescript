from distutils.log import debug
import cv2
from pathlib import PurePath
import traceback

class clsMain:
    def __init__(self) -> None:
        self.img = None
        self.cap = None
        self.scriptFull = PurePath(__file__)
        self.scriptPath = str(PurePath(self.scriptFull.parent))     
        self.debug = False   
        self.vid = None

    def main(self):
        '''Primary start function'''
        pass       

    def maakEenFotoEnSave(self):
        '''maak een foto en bewaar in dezelfde map'''

        try:
            self.vid = cv2.VideoCapture(0)
            outFileJPG = f'''{self.scriptPath}/maakEenFotoEnSave.jpg'''
            print(f'''outFileJPG={outFileJPG}''')

            ret, frame = self.vid.read()        
            cv2.imwrite(filename=outFileJPG, img=frame)            
            self.vid.release()
            print("Bestand is opgeslagen.")
        except Exception as ex1:
            print(traceback.print_exc())


if __name__ == "__main__":  
    print("App start")
    print(f"")

    main1 = clsMain()
    main1.debug = True  
    result1 = main1.maakEenFotoEnSave()

    print(f"SYNOPIS:")
    print(f"Maak een foto met OpenCV")
    print(f"")
    print("App eind")

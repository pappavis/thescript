#!/home/pi/venv/venv/bin/python
# Deze vooorbeeld maakt een foto met CV2 en slaat het lokaal op, daarna versturen naar MQQT server.

from distutils.log import debug
import cv2
from pathlib import PurePath
import traceback
import paho.mqtt.client as mqtt
import uuid
from datetime import datetime

class clsMain:
    def __init__(self) -> None:
        self.img = None
        self.cap = None
        self.scriptFull = PurePath(__file__)
        self.scriptPath = str(PurePath(self.scriptFull.parent))     
        self.debug = False   
        self.vid = None
        self.mqqtBroker = None

    def main(self, mqqtBroker="100.112.69.77"):
        '''Primary start function'''
        pass


    def maakEenFotoEnSave(self):
        '''maak een foto en bewaar in dezelfde map'''

        outFileJPG = None

        self.vid = cv2.VideoCapture(0)
        outFileJPG = f'''{self.scriptPath}/opencv_webcamfoto.jpg'''
        print(f'''outFileJPG={outFileJPG}''')

        ret, frame = self.vid.read()        
        cv2.imwrite(filename=outFileJPG, img=frame)            
        self.vid.release()
        print("Bestand is opgeslagen.")

        return outFileJPG


    def getMQQTClient(self, mqqtBroker="100.112.69.77"):
        '''return een Verbinding maken met een MQQT server
            @param mqqtBroker IP-adres of hostname
        '''
        mqqtClient  = mqtt.Client()

        if(self.mqqtBroker is None):
            self.mqqtBroker = mqqtBroker

        mqqtClient.connect(host=self.mqqtBroker, port=1883, keepalive=60)

        return mqqtClient

    def verstuurHalloWereldMetMQQT(self):
        '''Verstuur de hallo wereld tekstje naar een MQQT server'''
        mqqtClient = self.getMQQTClient()
        mqqtClientID=f"mqqt_{uuid.uuid4()}"

        txtLog1 = f"Hallo wereld {datetime.now} van Python {mqqtClientID}"
        mqqtClient.publish("picamStill/hallo_wereld", txtLog1);
        
        if(self.debug):
            txtLog1 = f"tekstje Hallo wereld gepubliceerd"
            print(txtLog1)

        mqqtClient.disconnect()


    def verstuurFotoMetMQQT(self, filename=None):
        '''Verstuur de plaatje naar een MQQT server 
        @param filename het plaatje om naar MQQT te versturen.
        '''
        mqqtClient = self.getMQQTClient()

        fotoBinIn1 = open(file=filename, mode="rb")
        fotoBinData = fotoBinIn1.read()
        fotoBinIn1.close()

        pubSubject = "picamStill/foto_in"
        mqqtClient.publish(pubSubject, fotoBinData);
        
        if(self.debug):
            txtLog1 = f"foto gepubliceerd. Mqqt_broker={self.mqqtBroker}, Subject={pubSubject}"
            print(txtLog1)

        mqqtClient.disconnect()


    def verstuurHalloWereldMetMQQT(self):
        '''Verstuur de plaatje naar een MQQT server'''
        mqqtClientID=f"mqqt_{uuid.uuid4()}"
        mqqtClient  = self.getMQQTClient()
        txtLog1 = f"Hallo wereld!"
        mqqtClient.publish("picamStill/hallo_wereld", txtLog1);
        
        if(self.debug):
            txtLog1 = f"tekstje Hallo wereld gepubliceerd"
            print(txtLog1)

        mqqtClient.disconnect()


if __name__ == "__main__":  
    print("App start")
    print(f"")
    print(f"SYNOPIS:")
    print(f"Maak een foto met OpenCV")
    print(f"")
    main1 = clsMain()
    main1.debug = True  
    main1.mqqtBroker="100.112.69.77"
    result1 = main1.maakEenFotoEnSave()
    main1.verstuurHalloWereldMetMQQT()
    main1.verstuurFotoMetMQQT(filename=result1)

    print("App eind")

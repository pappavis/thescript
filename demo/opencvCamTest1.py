import cv2
from pygrabber.dshow_graph import FilterGraph
# ref --> https://stackoverflow.com/questions/57577445/list-available-cameras-opencv-python

class clsMain:
    def __init__(self) -> None:
        self.__VideoCaptureDeviceToUse = 0
        
    def list_ports(self):
        """
        Test the ports and returns a tuple with the available ports and the ones that are working.
        """
        non_working_ports = []
        dev_port = 0
        working_ports = []
        available_ports = []
        while len(non_working_ports) < 6: # if there are more than 5 non working ports stop the testing. 
            camera = cv2.VideoCapture(dev_port)
            if not camera.isOpened():
                non_working_ports.append(dev_port)
                print("Port %s is not working." %dev_port)
            else:
                is_reading, img = camera.read()
                w = camera.get(3)
                h = camera.get(4)
                if is_reading:
                    print("Port %s is working and reads images (%s x %s)" %(dev_port,h,w))
                    working_ports.append(dev_port)
                else:
                    print("Port %s for camera ( %s x %s) is present but does not reads." %(dev_port,h,w))
                    available_ports.append(dev_port)
            dev_port +=1
        return available_ports,working_ports,non_working_ports

    @property
    def videoCaptureDevices(self):
        '''Returns a list of video capture devices'''
        graph = FilterGraph()
        vidDevices = graph.get_input_devices()

        return vidDevices


    @property
    def VideoCaptureDeviceToUse(self):
        vidDevice = cv2.VideoCapture(self.__VideoCaptureDeviceToUse)
        return vidDevice
    
    @VideoCaptureDeviceToUse.setter
    def VideoCaptureDeviceToUse(self, value):
        graph = FilterGraph()
        self.__VideoCaptureDeviceToUse = value
        try:
            device =graph.get_input_devices().index(value)
        except ValueError as e:
            device = graph.get_input_devices().index("Integrated Webcam")#use default camera if the name of the camera that I want to use is not in my list
        
        return device

if __name__ == "__main__":
    print("APP start")
    main1 = clsMain()
    vdev = main1.videoCaptureDevices
    devNr = 0

    for item1 in vdev:
        print(f'''{devNr} = {item1}''')
        devNr += 1

    main1.VideoCaptureDeviceToUse = 0

    print(f'''Geselecteerde videoCaptureDevice={main1.VideoCaptureDeviceToUse}''')
    print("APP eind")

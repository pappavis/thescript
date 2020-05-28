# https://github.com/chrisrossx/DotStar_Emulator

# Attempt to import the real library, but if it doesn't exists then 
# import the spoofed emulator version.
try:
    from dotstar import Adafruit_DotStar
except ImportError:
    from DotStar_Emulator import Adafruit_DotStar


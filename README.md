# INTRO
Clean install script for Raspberry Pi 1, 2,3,4  en x64_Ubuntu Linux semi-automtaing installing useful tools.
 - Uitgebreide swapfile naar 2Gb
 - Python 3.9 virtual environment
 - Micropython, Circuitpython
 - LAMP-stack (mySQL, sqlite, PHP)
 - Homeassistant, Apple <a href="https://www.npmjs.com/package/homebridge" target="_blank">Homebridge</a>
 - Grafana
 - Node-red + veel uitbreidingen
 - <a href="virtualhere.com" target="blank">Virtualhere</a> USB apparaten aansluiten via WiFi

# Voorvereisten
- Je gebruikt RaspberryPiOS, MacOS of Ubuntu/Linux
- SD Card van minimaal 32Gb
- Je hebt minimaal >=Python 3.7 en virtualenv  alreeds geïnstalleerd
- Je bent ingelogd als gebruiker pi

# Stappenplan
Dit vergemakkelijk jouw leven op een Pi.

## Stap 1:
Download <a href="https://www.raspberrypi.org/software/" target="_blank">Raspberry Pi Imager</a> en flash Raspian naar een SD-kaart.

<img src="https://assets.raspberrypi.com/static/md-bfd602be71b2c1099b91877aed3b41f0.png" width="30%" height="30%">

# Stap 2:
2.1 Als eerste:
 - Login: pi
 - Password: raspberry

2.2 en Wifi instellen via Raspi-config:

<img src="https://www.raspberrypi.org/documentation/computers/images/raspi-config.png" width="30%" height="30%">

2.3 SSH activeren:
 - Kies optie Interfaces, kies SSH, kies YES om te activeren
 - Kies optie Exit

2.4 Raspi-config afsluiten.

```bash
pi@raspberrypi: $ sudo raspi-config
pi@raspberrypi: $ reboot
```

## Stap 3:
Na reboot. Bijwerken en gebruikersrechten instellen.
Deze script is 95% autonoom, je moet op gegeven moment wel de phpMyadmin wachtwoord instellen.

```bash
pi@raspberrypi: $ mkdir ~/Downloads
pi@raspberrypi: $ sudo apt install -y git
pi@raspberrypi: $ git clone https://github.com/pappavis/thescript/
pi@raspberrypi: $ cd ~/Downloads/thescript
pi@raspberrypi: $ bash ./runmefirst.sh
pi@raspberrypi: $ sudo mysql_secure_installation
pi@raspberrypi: $ reboot
```

## Stap 4:
Na reboot. Installeren Virtualhere en minimale Pi desktop

Let op doorlooptijd: 
 - Pi zero duurt dit >=2,5 uren!!!
 - Pi 3 duurt <>80 minuten
 - Pi 4 duurt <>40 minuten
 - x86 Ubuntu op een 2012-bouwjaar <a href="https://tweakers.net/pricewatch/281758/acer-aspire-one-722/specificaties/" target="_blank">Acer Aspire One</a> duurt <>20 minuten

```bash
pi@raspberrypi: $ cd ~/Downloads/thescript
pi@raspberrypi: $ bash ./installVerzamelupdates.sh
pi@raspberrypi: $ reboot
```

## Stap 5: Python 3 en circuitpython bijwerken
Super handig installeert virtualenvironment voor Python, CircuitPython, tesseractOCR en Micropython.

```bash
pi@raspberrypi: $ cd ~/Downloads
pi@raspberrypi: $ git clone https://github.com/pappavis/thescript/
pi@raspberrypi: $ cd ~/Downloads/thescript/
pi@raspberrypi: $ bash ./installVerzamelupdates.sh
pi@raspberrypi: $ bash ./installExtras.sh
```


## Optioneel stap 6: installeren <a href="https://tech.scargill.net/the-script/" target="_blank">Pete Scargill</a> script
Let op.
 - In deze script moet je nginix/apache NIET aanvinken want dat zijn al geïnstalleerd!!
 - Op een pi zero duurt het install >=2 uren.

```bash
pi@raspberrypi: $ sudo apt install -y git
pi@raspberrypi: $ cd ~/Downloads
pi@raspberrypi: $ git clone https://github.com/pappavis/thescript/
pi@raspberrypi: $ cd thescript && wget https://bitbucket.org/api/2.0/snippets/scargill/kAR5qG/master/files/script.sh
pi@raspberrypi: $ bash ./script.sh
pi@raspberrypi: $ sudo reboot -h now
```

# origineel
Zie origineel <a href="https://bitbucket.org/api/2.0/snippets/scargill/kAR5qG/master/files/script.sh">hier</a>


# INTRO
Clean install script for Raspberry Pi 1, 2,3,4  en x64_Ubuntu Linux semi-automtaing installing useful tools.
 - Uitgebreide swapfile naar 2Gb
 - Python 3.9 virtual environment
 - <a href="https://micropython.org/" target="blank">Micro</a>python, <a href="https://circuitpython.org">Circuit</a>python
 - LAMP-stack (mySQL, sqlite, PHP)
 - Homeassistant, Apple <a href="https://www.npmjs.com/package/homebridge" target="_blank">Homebridge</a>
 - Grafana
 - Node-red + veel uitbreidingen
 - <a href="virtualhere.com" target="blank">Virtualhere</a> USB apparaten aansluiten via WiFi

# Voorvereisten
- Je gebruikt RaspberryPi OS, MacOS of Ubuntu/Linux
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
pi@raspberrypi $ mkdir ~/Downloads
pi@dietpi:~/Downloads $ sudo apt install -y git
pi@dietpi:~/Downloads $ git clone https://github.com/pappavis/thescript/
pi@dietpi:~/Downloads $ cd ~/Downloads/thescript
pi@dietpi:~/Downloads/thescript $ nohup bash ./runmefirst.sh &
```
Dit duurt circa <>45 minuten op een Pi 3.

## Stap 4:
Bijwerken en gebruikersrechten instellen.

```
pi@raspberrypi $ sudo mysql_secure_installation
pi@raspberrypi $ sudo mysql -u root -p
Welcome to the MariaDB monitor.  Commands end with ; or \g.
Your MariaDB connection id is 40
Server version: 10.3.31-MariaDB-0+deb10u1 Raspbian 10

Copyright (c) 2000, 2018, Oracle, MariaDB Corporation Ab and others.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

MariaDB [(none)]> CREATE USER 'michiele'@'localhost' IDENTIFIED BY 'password';
Query OK, 0 rows affected (0.012 sec)
MariaDB [(none)]> GRANT ALL PRIVILEGES ON *.* TO 'michiele'@'localhost' WITH GRANT OPTION;
Query OK, 0 rows affected (0.007 sec)
MariaDB [(none)]> FLUSH PRIVILEGES;
Query OK, 0 rows affected (0.006 sec)
MariaDB [(none)]> exit;
Bye
pi@raspberrypi: $ reboot
```

## Stap 5:
Na reboot. Installeren Virtualhere en minimale Pi desktop

Let op doorlooptijd: 
 - Pi zero duurt dit >=2,5 uren!!!
 - Pi 3 duurt <>80 minuten
 - Pi 4 duurt <>40 minuten
 - x86 Ubuntu op een 2012-bouwjaar <a href="https://tweakers.net/pricewatch/281758/acer-aspire-one-722/specificaties/" target="_blank">Acer Aspire One</a> duurt <>20 minuten

```bash
pi@raspberrypi: $ cd ~/Downloads/thescript
pi@dietpi:~/Downloads/thescript $ nohup bash ./installExtrasLite.sh &
pi@dietpi:~/Downloads/thescript $ tail -f ./nohupout
```

Het draaien van installExtrasLite.sh duurt tot wel 1,5 uur!

## Stap 6: Python 3 en circuitpython bijwerken
Super handig installeert virtualenvironment voor Python, CircuitPython, tesseractOCR en Micropython.

```bash
pi@raspberrypi: $ cd ~/Downloads
pi@dietpi:~/Downloads $ git clone https://github.com/pappavis/thescript/
pi@dietpi:~/Downloads $ cd ~/Downloads/thescript/
pi@dietpi:~/Downloads/thescript $ bash ./installPythonCircuitpython.sh
pi@dietpi:~/Downloads/thescript $ nohup bash ./installExtras.sh &
```

## Stap 7: Test website
Surf naar http://jouwRaspberryPi.local/

## Stap 8: Pi bijgewerkt houden
Installeer een Crontab om de pi regelmatig bij te werken en het swapfile op te schoon. Het swapfile loopt vol en de Pi wordt traag. 

```bash
(venv) pi@dietpi:~ $ crontab -e
```

Installeer de volgende in crontab
```cron
10 1 * * * sudo bash /home/pi/Downloads/thescript/autoupdate.sh
0 */9 * * * sudo bash /home/pi/Downloads/thescript/swap_opruimen.sh
                             [ 27 regels gelezen ]
^G Hulp      ^O Opslaan   ^W Zoeken    ^K Knippen   ^T Opdracht  ^C Positie
^X Afsluiten ^R Inlezen   ^\ Vervangen ^U Plakken   ^J Uitvullen ^_ Naar regel
```
Afsluiten af met ctrl-x

```bash
crontab: installing new crontab
(venv) pi@dietpi:~ $
```

# origineel
Zie origineel <a href="https://bitbucket.org/api/2.0/snippets/scargill/kAR5qG/master/files/script.sh">hier</a> door Pete Scargill.


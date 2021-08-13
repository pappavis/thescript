# INTRO
Handige Raspberry Pi 2,3,4 script om jouw pi te setup

# Stappenplan
Dit vergemakkelijk jouw leven op een Pi

## Stap 1: installeren Pete Scargill script
Login op jouw Pi als gebruiker pi.  NIET op Pi0 dit duurt te lang!!

```bash
pi@rpasberrypi: $ git clone https://github.com/pappavis/thescript/
pi@rpasberrypi: $ cd thescript && wget https://bitbucket.org/api/2.0/snippets/scargill/kAR5qG/master/files/script.sh
pi@rpasberrypi: $ bash ./script.sh
pi@rpasberrypi: $ sudo reboot -h now
```

## Stap 2: Python 3 en circuitpython
Super handig

```bash
pi@rpasberrypi: $ git clone https://github.com/pappavis/thescript/
pi@rpasberrypi: $ cd ./thescript/
pi@rpasberrypi: $ bash ./installPythonVirtualenv.sh
pi@rpasberrypi: $ bash ./installPythonCircuitpython.sh
```

# origineel
Zie origineel <a href="https://bitbucket.org/api/2.0/snippets/scargill/kAR5qG/master/files/script.sh">hier</a>


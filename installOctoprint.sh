echo "SETUP: Skep octoprint virtualenv."
~/.local/bin/virtualenv ~/venv/OctoPrint
echo "SETUP: Aktiveer virtualenv."
source ~/venv/OctoPrint/bin/activate
pip3 install octoprint

echo "SETUP: pi toegang naar devices."
sudo usermod -a -G tty pi
sudo usermod -a -G dialout pi

echo "SETUP: Installeer als service."
wget https://github.com/foosel/OctoPrint/raw/master/scripts/octoprint.init && sudo mv octoprint.init /etc/init.d/octoprint
wget https://github.com/foosel/OctoPrint/raw/master/scripts/octoprint.default && sudo mv octoprint.default /etc/default/octoprint
sudo chmod +x /etc/init.d/octoprint

echo "DAEMON=/home/pi/venv/OctoPrint/venv/bin/octoprint" >> /etc/default/octoprint
sudo update-rc.d octoprint defaults
echo "SETUP: Start octoprint service."
sudo service octoprint restart

source ~/venv/venv3.7/bin/activate

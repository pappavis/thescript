LOGFILE=$HOME/logs/installOctoprint-`date +%Y-%m-%d_%Hh%Mm`.log
_pwd=$(pwd)
_hn1=$(hostname)
mkdir $HOME/logs
echo "SETUP: Skep octoprint virtualenv." | tee -a $LOGFILE
~/.local/bin/virtualenv ~/venv/oprint | tee -a $LOGFILE
echo "SETUP: Aktiveer virtualenv." | tee -a $LOGFILE
source ~/venv/oprint/bin/activate
bash $_pwd/installOctoprintPlugins.sh
echo "einde octoprint install." | tee - a logfile

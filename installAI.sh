#±/bin/bash
#ref https://nodeshift.com/blog/how-to-install-dolphin-3-0-llama-3-1-8b-locally
#20250303 0.01 eerste versie
LOGFILE=$HOME/logs/installAI-`date +%Y-%m-%d_%Hh%Mm`.log
sudo mkdir /usr/local/bin  2>&1 | tee -a $LOGFILE
BINDIR=/usr/local/bin
export BINDIR=/usr/local/bin

curl -fsSL https://ollama.com/install.sh | sh 2>&1 | tee -a $LOGFILE
ollama serve 2>&1 | tee -a $LOGFILE
ollama pull dolphin3 2>&1 | tee -a $LOGFILE
ollama run dolphin3



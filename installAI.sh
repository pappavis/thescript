#±/bin/bash
#ref https://nodeshift.com/blog/how-to-install-dolphin-3-0-llama-3-1-8b-locally
#20250303 0.01 eerste versie
LOGFILE=$HOME/logs/installAI-`date +%Y-%m-%d_%Hh%Mm`.log
sudo mkdir /usr/local/bin  2>&1 | tee -a $LOGFILE
BINDIR=/usr/local/bin
export BINDIR=/usr/local/bin

echo "" 2>&1 | tee -a $LOGFILE
echo "START installAI.sh" 2>&1 | tee -a $LOGFILE
echo '** Installeer Kunstmatige intilligentie. Je moet eerst een virtualenv activeer!!'  2>&1 | tee -a $LOGFILE
source ~/venv/venv/bin/activate

for addonnodes in curl ollama ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren Kunstmatige Intilligentie hulp: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    sudo apt install $NQUIET -y ${addonnodes} 2>&1 | tee -a $LOGFILE
    #conda install --upgrade --no-cache-dir  ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done


for addonnodes in langgraph langchain-openai langchain duckduckgo-search langchain-community langchain-experimental langchain-ollama langgraph-prebuilt tavily-python tinydb  lanceDB open-webui ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren Kunstmatige  python lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade --break-system-packages ${addonnodes} 2>&1 | tee -a $LOGFILE
    #conda install --upgrade --no-cache-dir  ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done

echo "" 2>&1 | tee -a $LOGFILE
curl -fsSL https://ollama.com/install.sh | sh 2>&1 | tee -a $LOGFILE

ollama --version 2>&1 | tee -a $LOGFILE
ollama serve 2>&1 | tee -a $LOGFILE

for addonnodes in tinyllama dolphin3 phi3  ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren Kunstmatige Intilligentie LLM: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    ollama pull $NQUIET ${addonnodes} 2>&1 | tee -a $LOGFILE
    #conda install --upgrade --no-cache-dir  ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done

nohup ollama run tinyllama 2>&1 | tee -a $LOGFILE &
#ollama run dolphin-llama3:latest

curl http://localhost:11434/api/generate -d '{
  "model": "tinyllama",
  "prompt": "Why is the capital of Australia?",
  "stream": false
}' 

wget https://raw.githubusercontent.com/pappavis/thescript/master/services/open-webui.service  2>&1 | tee -a $LOGFILE
sudo mv ./open-webui.service /etc/systemd/system  2>&1 | tee -a $LOGFILE
sudo systemctl enable open-webui.service  2>&1 | tee -a $LOGFILE
sudo service open-webui restart  2>&1 | tee -a $LOGFILE

nohup open-webui serve  2>&1 | tee -a $LOGFILE &

echo "EINDE installAI.sh" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

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

for addonnodes in langgraph langchain-openai langchain duckduckgo-search langchain-community langchain-experimental langchain-ollama langgraph-prebuilt tavily-python tinydb  lanceDB open-webui ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren Kunstmatige Intilligentie python lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
    #conda install --upgrade --no-cache-dir  ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done

echo "" 2>&1 | tee -a $LOGFILE
curl -fsSL https://ollama.com/install.sh | sh 2>&1 | tee -a $LOGFILE
ollama serve 2>&1 | tee -a $LOGFILE
ollama pull dolphin3 2>&1 | tee -a $LOGFILE
ollama run dolphin-llama3:latest
echo "EINDE installAI.sh" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

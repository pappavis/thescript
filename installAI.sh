    #±/bin/bash
#ref https://nodeshift.com/blog/how-to-install-dolphin-3-0-llama-3-1-8b-locally
#20250303 0.01 eerste versie
LOGFILE=$HOME/logs/installAI-`date +%Y-%m-%d_%Hh%Mm`.log
HOSTNAME=$'hostname'
sudo mkdir /usr/local/bin  2>&1 | tee -a $LOGFILE
BINDIR=/usr/local/bin
export BINDIR=/usr/local/bin
OLLAMA_HOST=0.0.0.0:11434
export OLLAMA_HOST=0.0.0.0:11434
export OLLAMA_MODELS=/home/pi/.ollama/models/blobs/

echo "" 2>&1 | tee -a $LOGFILE
echo "START installAI.sh" 2>&1 | tee -a $LOGFILE
echo '** Installeer Kunstmatige intilligentie. Je moet eerst een virtualenv activeer!!'  2>&1 | tee -a $LOGFILE
source ~/venv/venv/bin/activate

mkdir $USER/.postgresql/
mkdir $USER/.postgresql/data

curl -sSL https://get.docker.com | sh 2>&1 | tee -a $LOGFILE
sudo usermod -aG docker $USER
docker run hello-world 2>&1 | tee -a $LOGFILE
docker run --name pgvector-container -e POSTGRES_USER=pi -e POSTGRES_PASSWORD=password -e POSTGRES_DB=mydatabase -p 5432:5432 -d ankane/pgvector  -v postgres_data:/home/pi/.postgresql/data 2>&1 | tee -a $LOGFILE
docker start pgvector-container 
docker restart postgres-service

sudo cp ./services/postgres-dockerservice.service /etc/systemd/system/postgres-dockerservice.service 2>&1 | tee -a $LOGFILE
sudo systemctl enable postgres-dockerservice.service
sudo systemctl start postgres-dockerservice.service
sudo systemctl status postgres-dockerservice.service

# sudo apt install -y postgresql postgresql-contrib  2>&1 | tee -a $LOGFILE

for addonnodes in docker-compose curl ollama exim4 ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren Kunstmatige Intilligentie hulp: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    sudo apt install $NQUIET -y ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done


for addonnodes in langgraph langchain-openai langchain duckduckgo-search langchain-community langchain-experimental langchain-ollama langgraph-prebuilt tavily-python tinydb  lanceDB open-webui torch torchaudio torchvideo diffusers gradio datasets soundfile speechbrain accelerate uv scipy torchsde aiohttp   ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren Kunstmatige  python lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade --break-system-packages ${addonnodes} 2>&1 | tee -a $LOGFILE
    #conda install --upgrade --no-cache-dir  ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done

echo "" 2>&1 | tee -a $LOGFILE
curl -fsSL https://ollama.com/install.sh | sh 2>&1 | tee -a $LOGFILE


# tutorial https://www.youtube.com/watch?v=qqjzohCle48

ollama --version 2>&1 | tee -a $LOGFILE
ollama serve 2>&1 | tee -a $LOGFILE

for addonnodes in tinyllama dolphin3 phi3 nomic-embed-text:latest llama3.2 moondream ; do
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

echo "OpenwebUI op 'cat /proc/sys/kernel/hostname'.local:8080"  2>&1 | tee -a $LOGFILE | sudo tee -a /etc/bash.bashrc &
echo "nohup open-webui serve &"  2>&1 | tee -a $LOGFILE | sudo tee -a /etc/bash.bashrc &

nohup lynx http://'cat /proc/sys/kernel/hostname'.local:8080  2>&1 | tee -a $LOGFILE

echo "install n8n AI Agents--> https://mathias.rocks/blog/2024-09-19-how-to-install-n8n-on-raspberry-pi"  2>&1 | tee -a $LOGFILE
for addonnodes in n8n pm2 ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren Kunstmatige Intilligentie LLM: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    sudo npm install -g $NQUIET ${addonnodes} 2>&1 | tee -a $LOGFILE
    #conda install --upgrade --no-cache-dir  ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done

for addonnodes in n8n-nodes-deepseek n8n-nodes-docx-converter n8n-nodes-firebird n8n-nodes-deepseek-llm n8n-nodes-custom n8n-nodes-openpix n8n-nodes-qrcode @fresent/n8n-nodes-tiktok n8n-nodes-docker  n8n-nodes-gemini-search@igabm/n8n-nodes-tiktok n8n-nodes-sqlite3 n8n-nodes-pdf-excel @skriptfabrik/n8n-nodes-barcode n8n-nodes-aistudio-updated n8n-nodes-langchain n8n-nodes-base n8n-nodes-notion-markdown n8n-nodes-mcp n8n-nodes-aistudio  n8n-nodes-globals n8n-nodes-unstract @digital-boss/n8n-nodes-mollie n8n-nodes-deepseek-llm n8n-nodes-pdfkit    n8n-nodes-docx-converter n8n-nodes-comfyui  n8n-nodes-python @inite/n8n-nodes-telepilot n8n-nodes-discord n8n-nodes-audio-tools n8n-nodes-ffmpeg @rxap/n8n-utilities n8n-nodes-speech2text n8n-nodes-sqlite  n8n-nodes-pdf-to-images  n8n-nodes-filemanager n8n-nodes-fill-docx n8n-nodes-whatsapp @marcuson/n8n-nodes-ics-utils n8n-nodes-duckduckgo-search @dapplets/n8n-nodes-telegram-utils n8n-nodes-browser n8n-nodes-robotframework n8n-nodes-form-login    ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren Kunstmatige Intilligentie LLM: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    npm install -g  $NQUIET ${addonnodes} 2>&1 | tee -a $LOGFILE
    #conda install --upgrade --no-cache-dir  ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done

# n8n auto install methode 1
# wget --no-cache -O - https://raw.githubusercontent.com/TephlonDude/n8n-pi/master/scripts/build-n8n-pi-1.sh | bash
wget https://gist.githubusercontent.com/Sclafus/9823cc863ad4d007d0ccfef048fa4942/raw/e66f8664967c8d9035cf12f19a2c36d4fb550dc6/n8n-install-pi.sh 2>&1 | sudo bash | tee -a $LOGFILE

# n8n auto install methode 2
# sudo apt install -y docker
#docker run -it --rm --name n8n -p 5678:5678 -v ~/.n8n:/root/.n8n n8nio/n8n:0.78.0-rpi

# n8n auto install methode 3
sudo systemctl disable n8n
wget https://raw.githubusercontent.com/pappavis/thescript/refs/heads/master/services/n8n.service  2>&1 | tee -a $LOGFILE
sudo mv -v ./n8n.service /etc/systemd/system/n8n.service 2>&1 | tee -a $LOGFILE
sudo systemctl enable n8n
sudo systemctl daemon-reload
sudo systemctl start n8n
sudo systemctl status n8n 2>&1 | tee -a $LOGFILE

echo "export N8N_SECURE_COOKIE=false" 2>&1 | sudo tee -a /etc/profile | tee -a $LOGFILE

#auto isntall methode 3
#pm2 start n8n 2>&1 | tee -a $LOGFILE
#pm2 list  2>&1 | tee -a $LOGFILE
# to autostart n8n:
#pm2 save
#pm2 startup

echo "OLLAMA_HOST=0.0.0.0:11434" 2>&1 | sudo tee -a /etc/profile | tee -a $LOGFILE
echo "export OLLAMA_HOST" 2>&1 | sudo tee -a /etc/profile | tee -a $LOGFILE


# https://supabase.com/docs/guides/self-hosting/docker
cd ~/Downloads
git clone --depth 1 https://github.com/supabase/supabase
mkdir supabase-project
cp -rf supabase/docker/* supabase-project
# Copy the fake env vars
cp supabase/docker/.env.example supabase-project/.env
# Switch to your project directory
cd supabase-project
# Pull the latest images
docker compose pull
# Start the services (in detached mode)
docker compose up -d

echo "Supbase bereikbaar op http://$HOSTNAME:8000" 2>&1 | tee -a $LOGFILE


# gratis ongecensureerd vids!!
cd ~/Dowloads
git clone https://github.com/lllyasviel/FramePack 2>&1 | tee -a $LOGFILE
git clone https://github.com/nari-labs/dia 2>&1 | tee -a $LOGFILE   #text naar spraak
git clone https://github.com/SandAI-org/Magi-1 2>&1 | tee -a $LOGFILE    #plaatjes en vids

git clone https://github.com/Lightricks/LTX-Video 2>&1 | tee -a $LOGFILE
# create env LTX-Video
python -m venv ./env 2>&1 | tee -a $LOGFILE
source ./env/bin/activate 2>&1 | tee -a $LOGFILE
python -m pip install -e .\[inference-script\] 2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone https://github.com/elevenlabs/elevenlabs-python
git clone https://github.com/comfyanonymous/ComfyUI 2>&1 | tee -a $LOGFILE
cd ~/Downloads/ComfyUI
pip install -r ./requirements 2>&1 | tee -a $LOGFILE
echo "lees mbt LTX Video --> https://comfyanonymous.github.io/ComfyUI_examples/ltxv/"  2>&1 | tee -a $LOGFILE
cd ~/Downloads/ComfyUI/models/checkpoints
wget https://huggingface.co/Lightricks/LTX-Video/resolve/main/ltx-video-2b-v0.9.5.safetensors 2>&1 | tee -a $LOGFILE
cd ~/Downloads/ComfyUI/models/text_encoders
wget https://huggingface.co/Comfy-Org/mochi_preview_repackaged/resolve/main/split_files/text_encoders/t5xxl_fp16.safetensors 2>&1 | tee -a $LOGFILE
nohup python ./main.py & 2>&1 | tee -a $LOGFILE
## LTX-Video eind

source ~/.bashrc 2>&1 | tee -a $LOGFILE

cd ~/Downloads

echo "\nACE-Step gratis muziek genereren  https://youtu.be/PO_u7xEaL5I?t=719"  2>&1 | tee -a $LOGFILE
git clone https://github.com/ace-step/ACE-Step 2>&1 | tee -a $LOGFILE
cd ./ACE-Step
for addonnodes in torch torchvision torchaudio  ; do
    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren Kunstmatige Intilligentie Ace-step muziek: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET ${addonnodes} 2>&1 | tee -a $LOGFILE
    #conda install --upgrade --no-cache-dir  ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done

pip install -e . 2>&1 | tee -a $LOGFILE
mkdir ./outputs
acestep --checkpoint_path /path/to/checkpoint --port 7865 --device_id 0 --share true --bf16 true  2>&1 | tee -a $LOGFILE &


## installeer supabase lokaal  -- DOCKER is nodig.
brew install node  # op macOS met Homebrew
npm install -g npx
cd ~/Downloads
npx create-next-app@latest my-app
cd ./my-app
npx supabase init
## Ga naar http://127.0.0.1:54323 om de webinterface van Supabase te openen.

cd ~/Dowloads/thescript
docker run --name pgadmin4 -e PGADMIN_DEFAULT_EMAIL=jaap@mijnemail.com PGADMIN_DEFAULT_PASSWORD=mypassword -d  dpage/pgadmin4a 2>&1 | tee -a $LOGFILE
nohup open-webui serve  2>&1 | tee -a $LOGFILE &


echo "EINDE installAI.sh" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
# 20250501 zie ook https://fal.ai/models?categories=text-to-audio en zoek hun github pages op !!!!!!!

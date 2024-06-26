echo "Installeren https://github.com/AIGC-Audio/AudioGPT" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone https://github.com/AIGC-Audio/AudioGPT 2>&1 | tee -a $LOGFILE
sudo mv ~/Downloads/AudioGPT /usr/local/apps 2>&1 | tee -a $LOGFILE
#/usr/bin/python3  -m virtualenv -p /usr/bin/python3 ~/venv/audiogpt 2>&1 | tee -a $LOGFILE
#source ~/venv/audiogpt/bin/activate 2>&1 | tee -a $LOGFILE
source ~/venv/venv/bin/activate 2>&1 | tee -a $LOGFILE

for addonnodes in accelerate addict==2.4.0 aiofiles albumentations==1.3.0 appdirs==1.4.4 basicsr==1.4.2 beautifulsoup4==4.10.0 Cython==0.29.24 diffusers \
	einops==0.3.0 espnet espnet_model_zoo ffmpeg-python  g2p-en==2.1.0 google==3.0.0 gradio  h5py imageio==2.9.0  imageio-ffmpeg==0.4.2  invisible-watermark==0.1.5  ; do

    echo "" 2>&1 | tee -a $LOGFILE
    echo "Installeren python lib: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install $NQUIET --upgrade ${addonnodes} 2>&1 | tee -a $LOGFILE
    #conda install --upgrade --no-cache-dir  ${addonnodes} 2>&1 | tee -a $LOGFILE
    echo "" 2>&1 | tee -a $LOGFILE
  done

for addonnodes in jieba kornia==0.6  langchain==0.0.101 librosa loguru miditoolkit==0.1.7 mmcv==1.5.0 mmdet==2.23.0  mmengine==0.7.2 moviepy==1.0.3 numpy==1.23.1 omegaconf==2.1.1 \
	open_clip_torch==2.0.2  openai openai-whisper opencv-contrib-python==4.3.0.36 praat-parselmouth==0.3.3 prettytable==3.6.0 proglog==0.1.9 pycwt==0.3.0a22 pyloudnorm==0.1.0  ; do
	
    echo "Installeren: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install --upgrade ${addonnodes}  2>&1 | tee -a $LOGFILE
done

for addonnodes in pypinyin==0.43.0  pytorch-lightning==1.5.0  pytorch-ssim==0.1  pyworld==0.3.0  resampy==0.2.2 Resemblyzer==0.1.1.dev0  safetensors==0.2.7  sklearn==0.0 soundfile \
	soupsieve==2.3 streamlit==1.12.1  streamlit-drawable-canvas==0.8.0  tensorboardX==2.4  test-tube=0.7.5  TextGrid==1.5  timm==0.6.12  torch==1.12.1  torchaudio==0.12.1 \
	torch-fidelity==0.3.0  torchlibrosa  torchmetrics==0.6.0  torchvision==0.13.1  transformers==4.26.1  typing-extensions==4.0.0  uuid==1.30  webdataset==0.2.5  webrtcvad==2.0.10  ; do
	yapf==0.32.0  git+https://github.com/openai/CLIP.git
    echo "Installeren: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install --upgrade ${addonnodes}  2>&1 | tee -a $LOGFILE
done


nohup python /usr/local/apps/AudioGPT/audio-chatgpt.py 2>&1 | tee -a $LOGFILE &

echo "Installeren https://github.com/xtekky/gpt4free" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone https://github.com/xtekky/gpt4free 2>&1 | tee -a $LOGFILE
sudo mv ~/Downloads/gpt4free /usr/local/apps 2>&1 | tee -a $LOGFILE
#/usr/bin/python3  -m virtualenv -p /usr/bin/python3 ~/venv/gpt4free 2>&1 | tee -a $LOGFILE
#source ~/venv/gpt4free/bin/activate 2>&1 | tee -a $LOGFILE
source ~/venv/venv/bin/activate 2>&1 | tee -a $LOGFILE
for addonnodes in websocket-client requests tls-client pypasser names  colorama  curl_cffi streamlit==1.21.0 \
  selenium  fake-useragent  twocaptcha  https://github.com/AI-Yash/st-chat/archive/refs/pull/24/head.zip  qpydantic  pymailtm	
    echo "Installeren: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install --upgrade ${addonnodes}  2>&1 | tee -a $LOGFILE
done

rm -rf ~/Downloads/AudioGPT 2>&1 | tee -a $LOGFILE &
rm -rf ~/Downloads/gpt4free 2>&1 | tee -a $LOGFILE &

nohup python /usr/local/apps/AudioGPT/audio-chatgpt.py 2>&1 | tee -a $LOGFILE &

source ~/.bashrc

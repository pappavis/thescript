#/usr/bin/sh
LOGFILE=$HOME/logs/installPythonVirtualenv-`date +%Y-%m-%d_%Hh%Mm`.log
echo "Installeer nieuwe python3 virtuale omgeving" 2>&1 | tee -a $LOGFILE

for addonnodes in dialout tty gpio i2c docker ; do
  echo "Gebruiker $gebr rechten toewijzen aan groep:  \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
  sudo usermod $gebr -g ${addonnodes}  2>&1 | tee -a $LOGFILE
done

mkdir $HOME/logs/

usermod 
echo ""  2>&1 | tee -a $LOGFILE
echo "Uitvoeren installPythonVirtualenv.sh begint."  2>&1 | tee -a $LOGFILE
echo ""  2>&1 | tee -a $LOGFILE

#python3 -m pip install virtualenv
mkdir ~/venv
VENV="venv"
rm -rf ~/venv/$VENV
mkdir ~/venv
for addonnodes in  virtualenv python3-virtualenv python3-pip python3-wheel python3-setuptools ; do 
	echo  "Installing python virtualenv systeem benodigheden  \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
	sudo apt install -y ${addonnodes} 2>&1 | tee -a $LOGFILE
done
/usr/bin/python3  -m pip install virtualenv 2>&1 | tee -a $LOGFILE
/usr/bin/python3  -m virtualenv -p /usr/bin/python3 ~/venv/venv 2>&1 | tee -a $LOGFILE
#/usr/python/python3.11 -m pip install virtualenv 2>&1 | tee -a $LOGFILE
#~/.local/bin/virtualenv3.11 ~/venv/venv3.11
echo "source ~/venv/$VENV/bin/activate" >> ~/.bashrc
python3 -m pipx ensurepath  2>&1 | tee -a $LOGFILE
source ~/.bashrc
echo "Virtualenv versie: $(python -V)" 2>&1 | tee -a $LOGFILE
echo "PATH=$PATH:~/.local/bin" >> ~/.bashrc

for addonnodes in pipx pipenv wheel ; do
    echo "Installeren: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install --user --upgrade ${addonnodes}  2>&1 | tee -a $LOGFILE
done


echo "Installeren AudoGPT: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
cd ~/Downloads
git clone https://github.com/AIGC-Audio/AudioGPT 2>&1 | tee -a $LOGFILE
/usr/bin/python3  -m virtualenv -p /usr/bin/python3 ~/venv/audiogpt 2>&1 | tee -a $LOGFILE
source ~/venv/audiogpt/bin/activate 2>&1 | tee -a $LOGFILE
for addonnodes in accelerate addict==2.4.0 aiofiles albumentations==1.3.0 appdirs==1.4.4 basicsr==1.4.2 beautifulsoup4==4.10.0 Cython==0.29.24 diffusers \
	einops==0.3.0 espnet espnet_model_zoo ffmpeg-python  g2p-en==2.1.0 google==3.0.0 gradio  h5py imageio==2.9.0  imageio-ffmpeg==0.4.2  invisible-watermark>=0.1.5 \
	jieba kornia==0.6  langchain==0.0.101 librosa loguru miditoolkit==0.1.7 mmcv==1.5.0 mmdet==2.23.0  mmengine==0.7.2 moviepy==1.0.3 numpy==1.23.1 omegaconf==2.1.1 \
	open_clip_torch==2.0.2  openai openai-whisper opencv-contrib-python==4.3.0.36 praat-parselmouth==0.3.3 prettytable==3.6.0 proglog==0.1.9 pycwt==0.3.0a22 pyloudnorm==0.1.0 \
	pypinyin==0.43.0  pytorch-lightning==1.5.0  pytorch-ssim==0.1  pyworld==0.3.0  resampy==0.2.2 Resemblyzer==0.1.1.dev0  safetensors==0.2.7  sklearn==0.0 soundfile \
	soupsieve==2.3 streamlit==1.12.1  streamlit-drawable-canvas==0.8.0  tensorboardX==2.4  test-tube>=0.7.5  TextGrid==1.5  timm==0.6.12  torch==1.12.1  torchaudio==0.12.1 \
	torch-fidelity==0.3.0  torchlibrosa  torchmetrics==0.6.0  torchvision==0.13.1  transformers==4.26.1  typing-extensions==4.0.0  uuid==1.30  webdataset==0.2.5  webrtcvad==2.0.10 \
	yapf==0.32.0  git+https://github.com/openai/CLIP.git
	
    echo "Installeren: \"${addonnodes}\"" 2>&1 | tee -a $LOGFILE
    pip install --user --upgrade ${addonnodes}  2>&1 | tee -a $LOGFILE
done

source ~/.bashrc

echo "" 2>&1 | tee -a $LOGFILE
echo "InstallPythonVirtualenv afgerond." 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

bash ./installPythonLibs.sh  2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE
echo "" 2>&1 | tee -a $LOGFILE

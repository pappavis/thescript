# ref https://stackoverflow.com/questions/58185322/python3-7-no-module-named-pip

NOW_DIR=$(pwd)
sudo apt update
sudo apt install build-essential zlib1g-dev libncurses5-dev libgdbm-dev libnss3-dev libssl-dev libreadline-dev libffi-dev wget
mkdir ~/python_upgrade
cd ~/python_upgrade
curl -O https://www.python.org/ftp/python/3.9.0/Python-3.9.0b3.tgz
tar -xfz Python-3.9.0b3.tgz
cd Python-3.9.0b3
./configure --enable-optimizations
make -j $(nproc)
make altinstall
python3.9 --version
cd $NOW_DIR
echo " "
echo "verwyder python upgrade"
rm -rf ~/python_upgrade

sudo apt-get update
sudo apt-get -y install git cmake build-essential libgl1-mesa-dev libsdl2-dev \
libsdl2-image-dev libsdl2-ttf-dev libsdl2-gfx-dev libboost-all-dev \
libdirectfb-dev libst-dev mesa-utils xvfb x11vnc libsdl-sge-dev python3-pip
cd ..
git clone https://github.com/google-research/football.git
cd football
sudo apt-get -y install python3-venv
python3 -m venv football-env
source football-env/bin/activate
pip3 install scikit-build
pip3 install .
python3 -m pip install --upgrade pip setuptools
pip3 install tensorflow-gpu==1.15.*
pip3 install dm-sonnet==1.*
pip3 install git+https://github.com/openai/baselines.git@master
Xvfb :1 -screen 0 1280x720x24+32 -fbdir /var/tmp &
export DISPLAY=:1

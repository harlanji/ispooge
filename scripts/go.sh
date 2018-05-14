#!/bin/bash


# Add user to video group for access to rasppi cam
sudo usermod -aG video $USER


# Install basics
sudo apt-get install git screen


# Install development stuff
sudo apt-get install \
  docker.io \
  bluefish

sudo usermod -aG docker $USER



# Checkout projects


mkdir -p $HOME/p
cd $HOME/p


## TinyDC
git clone https://github.com/harlanji/tinydatacenter
alias lein=$HOME/p/tinydatacenter/lein-docker/lein.sh


cd tinydatacenter


cd rtmp-proxy-docker
./build.sh
cd ..


cd lein-docker
./build.sh
cd ..



cd cryogen-docker
./build.sh
cd ..

cd ..


## Cryogen (local fork)

git clone https://github.com/harlanji/cryogen-core
cd cryogen-core
lein install


cd ..

## iSpooge Live
git clone https://github.com/harlanji/ispooge


cd ispooge
scripts/build.sh

cd ..


read -p "Reboot now? " -n 1 -r
echo

if [[$REPLY =~ ^[Yy]$ ]]; then
  sudo reboot
fi

#!/usr/bin/env bash

# https://kkovacs.eu/cool-but-obscure-unix-tools
# https://stedolan.github.io/jq/
# https://github.com/jkbrzt/httpie

function install {
  local package=$1

  command -v apt > /dev/null 2>&1

  if (($? == 0)); then
    echo apt
    sudo apt-get install -y $package
    return
  fi
}

echo "deb-src http://ppa.launchpad.net/nathan-renniewaldock/flux/ubuntu xenial main" | sudo tee -a /etc/apt/sources.list.d/flux.list
echo "deb http://ppa.launchpad.net/nathan-renniewaldock/flux/ubuntu xenial main" | sudo tee /etc/apt/sources.list.d/flux.list
sudo apt-get update
sudo apt-get upgrade -y
#sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y

#/etc/default/keyboard -> XKBOPTIONS="ctrl:nocaps"

install software-properties-common
install tmux
install git
install htop
install atop
install vim
install tmux
install curl
install ack-grep
install silversearcher-ag
install powertop
install libreoffice
install vlc
install build-essential
install tar
install firmware-linux
install intel-microcode
install pepperflashplugin-nonfree
install lm-sensors
install guake
install gconf-service
install libgconf-2-4
install libnspr4
install libnss3
install libpango1.0-0
install libappindicator1
install libcurl3
install playonlinux
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
install gtk-theme-switch
install exuberant-ctags
install tree
install python3-dev
install python3-pip
sudo pip3 install thefuck
install pkg-config
install libx11-dev
install libgl1-mesa-dev
install libjpeg-dev
install libpng12-dev
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker $USER
sudo curl -L https://github.com/docker/compose/releases/download/1.12.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo apt-get install fluxgui
git clone https://github.com/glmark2/glmark2.git
cd glmark2 && ./waf configure --with-flavors=x11-gl && ./waf build -j 4 && sudo ./waf install && sudo strip -s /usr/local/bin/glmark2
rm -rf glmark2
\curl -sSL https://get.rvm.io | bash
source /home/$USER/.rvm/scripts/rvm
rvm install ruby-2.3.1

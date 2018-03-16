#!/usr/bin/env bash

# https://kkovacs.eu/cool-but-obscure-unix-tools
# https://stedolan.github.io/jq/
# https://github.com/jkbrzt/httpie

#/etc/default/keyboard -> XKBOPTIONS="ctrl:nocaps"

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
# 1. Add the Spotify repository signing keys to be able to verify downloaded packages
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
# 2. Add the Spotify repository
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt-get update
sudo apt-get upgrade -y
#sudo apt-get dist-upgrade -y
sudo apt-get autoremove -y

install software-properties-common
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
install libyaml-dev
install libgconf-2-4
install libnspr4
install libnss3
install libpango1.0-0
install libappindicator1
install libcurl3
install libpq-dev
install libevent-dev
install playonlinux
wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
sudo dpkg -i google-chrome-stable_current_amd64.deb
rm google-chrome-stable_current_amd64.deb
install gtk-theme-switch
install exuberant-ctags
install tree
install meld
install python3-dev
install python3-pip
sudo pip3 install thefuck
install pkg-config
install libx11-dev
install libgl1-mesa-dev
install libjpeg-dev
install libpng12-dev
install spotify-client
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker $USER
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
sudo apt-get install fluxgui
#git clone https://github.com/glmark2/glmark2.git
#cd glmark2 && ./waf configure --with-flavors=x11-gl && ./waf build -j 4 && sudo ./waf install && sudo strip -s /usr/local/bin/glmark2
#rm -rf glmark2
\curl -L https://get.rvm.io | bash -s stable --ruby
source /home/$USER/.rvm/scripts/rvm
wget https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz
tar -xzf tmux-2.6.tar.gz
cd tmux-2.6 && ./configure && make && sudo make install
rm -rf tmux-2.6*
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash

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

function remove {
  local package=$1

  command -v apt > /dev/null 2>&1

  if (($? == 0)); then
    echo apt
    sudo apt-get remove -y $package
    return
  fi
}

#install sudo
#exit 0
# adduser <username> sudo

install dirmngr
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
echo deb https://dl.winehq.org/wine-builds/debian/ stretch main | sudo tee /etc/apt/sources.list.d/wine.list
sudo add-apt-repository ppa:jonathonf/vim
sudo dpkg --add-architecture i386
sudo wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
sudo wget -q "https://dl.winehq.org/wine-builds/Release.key" -O- | sudo apt-key add -
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get autoremove -y

install software-properties-common
install git
install htop
install iotop
install atop
install vim
install tmux
install xclip
install zsh
install curl
install ack-grep
install silversearcher-ag
install powertop
install cups
install libreoffice
install vlc
install build-essential
install tar
install firmware-linux
install intel-microcode
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
install libssl-dev
install libreadline-dev
install intltool
sudo apt-get install -y --install-recommends winehq-stable
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
install python-pygments
sudo pip3 install thefuck
install pkg-config
install libx11-dev
install libgl1-mesa-dev
install libjpeg-dev
install libpng-dev
install spotify-client
install ncurses-dev
install fonts-powerline
install fonts-roboto
install bash-completion
install python-pexpect
install python-gconf
install python-appindicator
install openvpn
install python3-setuptools
install python-expect
install intltool

# Openpyn
sudo python3 -m pip install openpyn --upgrade

# Other
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

# Docker 
curl -sSL https://get.docker.com/ | sh
sudo usermod -aG docker $USER
sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose

# Rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && echo 'eval "$(rbenv init -)"' >> ~/.bashrc && mkdir -p ~/.rbenv/plugins && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && rbenv install 2.5.1 && rbenv global 2.5.1

# Tmux
wget https://github.com/tmux/tmux/releases/download/2.6/tmux-2.6.tar.gz && tar -xzf tmux-2.6.tar.gz && cd tmux-2.6 && ./configure && make && sudo make install && cd .. && rm -rf tmux-2.6*

# Franz
wget https://github.com/meetfranz/franz/releases/download/v5.0.0-beta.17/franz_5.0.0-beta.17_amd64.deb && sudo dpkg -i franz_5.0.0-beta.17_amd64.deb && rm franz_5.0.0-beta.17_amd64.deb

# Nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash && nvm install node && npm install -g diff-so-fancy

# Redshift
wget https://github.com/jonls/redshift/releases/download/v1.11/redshift-1.11.tar.xz && tar -xf redshift-1.11.tar.xz && cd redshift-1.11 && ./configure && sudo make && sudo make install && cd .. && rm -rf redshift-1.11* && cp redshift.conf ~/.config/

# Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Remove Nano
remove nano

# Topicons
google-chrome https://extensions.gnome.org/extension/495/topicons/

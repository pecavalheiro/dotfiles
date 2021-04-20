#!/usr/bin/env bash

# https://kkovacs.eu/cool-but-obscure-unix-tools
# https://stedolan.github.io/jq/
# https://github.com/jkbrzt/httpie

#/etc/default/keyboard -> XKBOPTIONS="ctrl:nocaps"

set -e

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


# Postgres
sudo sh -c 'echo "deb [arch=amd64] http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list'
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -
# /Postgres

# Spotify
curl -sS https://download.spotify.com/debian/pubkey_0D811D58.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
# /Spotify

# Wine/PlayOnLinux
sudo dpkg --add-architecture i386
sudo wget -q "http://deb.playonlinux.com/public.gpg" -O- | sudo apt-key add -
echo deb http://deb.playonlinux.com/ stretch main | sudo tee /etc/apt/sources.list.d/playonlinux.list
# /Wine/PlayOnLinux

# Docker
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88 # Docker
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/debian buster stable"
# /Docker

# 1Password
sudo apt-key --keyring /usr/share/keyrings/1password.gpg adv --keyserver keyserver.ubuntu.com --recv-keys 3FEF9748469ADBE15DA7CA80AC2D62742012EA22
echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/1password.gpg] https://downloads.1password.com/linux/debian edge main' | sudo tee /etc/apt/sources.list.d/1password.list
# /1Password

# OpenRazer
echo 'deb http://download.opensuse.org/repositories/hardware:/razer/Debian_Testing/ /' | sudo tee /etc/apt/sources.list.d/hardware:razer.list
curl -fsSL https://download.opensuse.org/repositories/hardware:razer/Debian_Testing/Release.key | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/hardware_razer.gpg > /dev/null
# /OpenRazer

# TeamViewer
wget https://download.teamviewer.com/download/linux/teamviewer_amd64.deb
sudo apt install ./teamviewer_amd64.deb
rm teamviewer_amd64.deb

# make sources changes effective
sudo apt-get update

# docker
install apt-transport-https
install ca-certificates
install curl
install gnupg-agent
install software-properties-common
install docker-ce
install docker-ce-cli
install containerd.io
# /docker

# Wine/PlayOnLinux
install wine
install wine32
install wine64
install libwine
install libwine:i386
install fonts-wine
install playonlinux
# /Wine

# Postgres
install libpq-dev
# /Postgres

install spotify-client
install git
install htop
install iotop
install vim
install tmux
install zsh
install silversearcher-ag
install powertop
install libreoffice
install vlc
install tar
install guake
install exuberant-ctags
install tree
install meld
install python3-dev
install python3-pip
install python3-pygments
install fonts-powerline
install fonts-roboto
install 1password
install direnv
install snapd
install yarn
install postgresql-9.6
install openrazer-meta
install libpam-fprintd

# Lenovo webcam management
install v4l2loopback-utils

# Direnv
echo 'eval "$(direnv hook bash)"' >> ~/.bashrc

# Thefuck
sudo pip3 install thefuck

# Vim Plug
curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

# Rbenv
install openssl
install libssl-dev
git clone https://github.com/rbenv/rbenv.git ~/.rbenv && echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc echo 'eval "$(rbenv init -)"' >> ~/.bashrc && mkdir -p ~/.rbenv/plugins && git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build && rbenv install 2.7.2 && rbenv global 2.7.2

# Tmux
install libevent-dev
install libncurses5-dev
wget https://github.com/tmux/tmux/releases/download/3.1b/tmux-3.1b.tar.gz && tar -xzf tmux-3.1b.tar.gz && cd tmux-3.1b && ./configure && make && sudo make install && cd .. && rm -rf tmux-3.1*

# Nvm
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.37.2/install.sh | bash && nvm install node && npm install -g diff-so-fancy && npm install dredd --global && npm install aglio --global


# Tmux Plugin Manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Remove Nano
remove nano

# Apple magic keyboard configs
# default with Fn keys
# sudo echo 2 >> /sys/module/hid_apple/parameters/fnmode
# swap option with command key
# sudo echo 1 >> /sys/module/hid_apple/parameters/swap_opt_cmd
# /Apple magic keyboard 

echo "Manual steps:"
echo "Enroll fingerprint: fprintd-enroll"
echo "Add fingerprint to auth: sudo pam-auth-update"
echo "Install ExpressVPN (download directly from website)"
echo "Install patched hid_apple and set configs above (https://github.com/free5lot/hid-apple-patched)"
echo "Install Franz (check franz-debian-bullseye)"
echo "Check if tmux is being used in Guake"
echo "Install fzf: git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf and run install"
echo "Finish installing snap after logoff or reboot with sudo snap install core"
echo "Install Heroku CLI sudo snap install --classic heroku"
echo "Install Thunderbird sudo snap install thunderbird"
echo "Install flameshot sudo snap install flameshot"
echo "Add keyboard shortcut for Guake, Flameshot, 1Password"
echo "Set keyboard as English (inlt. with AltGr dead keys)"
echo "Install zeus pre: gem install --pre zeus"
echo "Install HPlib https://developers.hp.com/hp-linux-imaging-and-printing/gethplip"
echo "Install Sound Switcher - sudo snap install indicator-sound-switcher"
echo "Add Flameshot and Sound Switcher to startup apps"
echo "Install Polychromatic (open razer). Might need to be manual .deb install. Might require oldlib http://ftp.br.debian.org/debian/pool/main/liba/libappindicator/gir1.2-appindicator3-0.1_0.4.92-8_amd64.deb"

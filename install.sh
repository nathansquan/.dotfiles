#!/bin/bash

###############################
# Install Nerd Font
###############################

sudo apt-get -y install fontconfig
cd ~
wget https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/JetBrainsMono.zip
mkdir -p ~/.local/share/fonts
mkdir JetBrainsMono
unzip JetBrainsMono.zip -d JetBrainsMono
mv JetBrainsMono ~/.local/share/fonts
rm JetBrainsMono.zip

###############################
# Install tmux
###############################

sudo apt-get -y install tmux

###############################
# Build neovim from source
###############################

# install build prerequisites
sudo apt-get install ninja-build gettext cmake curl build-essential git

git clone https://github.com/neovim/neovim
cd neovim
make CMAKE_BUILD_TYPE=RelWithDebInfo
sudo make install

###############################
# Set up symlinks
###############################

sudo apt-get -y install stow
cd ~/.dotfiles
stow tmux
stow nvim

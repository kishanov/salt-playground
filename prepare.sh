#!/bin/sh

sudo apt-get -y update
sudo apt-get -y install python-software-properties tmux vim
sudo add-apt-repository -y ppa:saltstack/salt
sudo apt-get -y update

#!/bin/bash

#First Run only
sudo apt install vlc -y

sudo mkdir /etc/minion/
sudo chown -R $USER /etc/minion/
wget  https://minion.apointless.space/downloads/minion.sh 
wget  https://minion.apointless.space/downloads/kill-minion.sh
wget  
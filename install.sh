#!/bin/bash

#First Run only
sudo apt install curl vlc -y

sudo mkdir /etc/minion/
sudo chown -R $USER /etc/minion/
wget  
#!/bin/bash
#VARIABLES

#Text Colour
YL='\033[1;33m' #Yellow Text
NC='\033[0m' #No Color
BL='\033[0;34m' #Blue Text


# Hostname for this minion
#MINION_HOSTNAME="minion-01"
# HTTP base address of the control server. No trailing slash.
#MOTHERSHIP="http://192.168.1.132:8080"

echo $(pwd)
printf "mothership: ${MOTHERSHIP}\n"

#Letting us know that the script did start
printf "${BL}Video Downloader Started${NC}"

#Waiting for VLC to start
sleep 60

#remove potential errors
rm /tmp/$MINION_HOSTNAME.vlc
rm /tmp/$MINION_HOSTNAME.vlc.*
sleep 1
#loop
 while :
 do
  echo
 #Download playlist
  wget "$MOTHERSHIP/$MINION_HOSTNAME.vlc" -O "/tmp/new-playlist.vlc"
  if [ "/tmp/new-playlist.vlc" -nt "/tmp/playlist.vlc" ]; then
    rm /tmp/playlist.vlc
	mv /tmp/new-playlist.vlc /tmp/playlist.vlc
    printf "${BL}VLC Restarting${NC}"
    echo
    #Kills VLC with PID
    kill $(ps aux | grep 'vlc' | awk '{print $2}')
  else
    echo "Sure enough, playlist.vlc is older."
  fi
  printf "${YL}Sleeping for 60 sec${NC}\n"
  sleep 60
 # sleep 3
  echo
  printf "${YL}Entering Loop${NC}\n"
done
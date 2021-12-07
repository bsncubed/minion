#!/bin/bash
#VARIABLES -- CHANGE FOR MACHINE

# Hostname for this minion
MINION_HOSTNAME="minion-02"
# HTTP base address of the control server. No trailing slash.
MOTHERSHIP="http://vm01.local"

YL='\033[1;33m' #Yellow Text
NC='\033[0m' #No Color
BL='\033[0;34m' #Blue Text

# SCRIPT ACTIONS

(

# Change system hostname for VNC access & zeroconf advertisement
# Requires passwordless sudo to be set up for given user
# should be line like this in /etc/sudoers "minion  ALL=(ALL) NOPASSWD: ALL"
sudo hostnamectl set-hostname "$MINION_HOSTNAME"

# Reload hostname for zeroconf -- sorts out ping & vnc advertisement
sudo systemctl restart avahi-daemon

# Restart VNC - bind new hostname
gsettings set org.gnome.Vino vnc-password 'minion'
systemctl --user restart vino-server.service

)&

HOSTNAME=$MINION_HOSTNAME
export HOSTNAME

export MOTHERSHIP
export MINION_HOSTNAME

#loop
while :
 do
  #Call update checker script
  /media/minion/Config/video-downloader.sh &
  # Download media playlist
  wget "$MOTHERSHIP/$MINION_HOSTNAME.vlc" -O "/tmp/playlist.vlc"
  #play plylist
  vlc --fullscreen --repeat --video-on-top --no-qt-privacy-ask --no-video-title --no-video-deco --no-sub-autodetect-file /tmp/playlist.vlc 
  printf "${YL}Everything is FINE${NC}"
  sleep 10
done
#!/bin/bash
kill $(ps aux | grep 'video-downloader.sh' | awk '{print $2}')
kill $(ps aux | grep 'vlc' | awk '{print $2}')
kill $(ps aux | grep 'minion.sh' | awk '{print $2}')
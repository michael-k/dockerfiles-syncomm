#! /bin/bash
##################################################################
# Script: pcsx2-docker.sh
# Version: 0.0.1-alpha (VERY ALPHA!)
#
# Description:
# A script for starting the PCSX2 docker container 
# It maps X11, sound, and persistant sotrage,
# 
# by Gregory S. Hayes <ghayes@redhat.com>
#
##################################################################

# Set some colors
red='\e[0;31m'
lpurp='\e[1;35m'
yellow='\e[1;33m'
NC='\e[0m' # No Color

echo -e "${lpurp}Grabbing X11 Cookie of host${NC}" 
# Get the X11 Cookie to pass
XCOOKIE=`xauth list | grep unix | cut -f2 -d"/" | tr -cd '\11\12\15\40-\176' | sed -e 's/  / /g'`

if [ ! -e /tmp/.pulse-socket ];
then
    echo -e "${lpurp}Adding Pulseaudio socket at /tmp/.pulse-socket${NC}" 
    pactl load-module module-native-protocol-unix auth-anonymous=1 socket=/tmp/.pulse-socket
fi

echo -e "${lpurp}Launching syncomm/netflix container${NC}" 
echo sudo docker run --rm -e XCOOKIE=\'$XCOOKIE\' -v /tmp/.X11-unix/:/tmp/.X11-unix/ -v /tmp/.pulse-socket:/tmp/.pulse-socket -v ~/pcsx-docker-drive:/.config/pcsx2 -t syncomm/pcsx2 | sh
exit 0

#!/bin/bash

CONFIG_FILE=/opt/teamviewer/config/global.conf

sudo apt-get install -y macchanger

# Make sure only root can run our script
if [[ $EUID -ne 0 ]]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

if [ ! -s $CONFIG_FILE  ]; then
  echo "$CONFIG_FILE not found! Teamviewer is installed?" 1>&2
  exit 1
fi

systemctl stop teamviewerd

lastMACUsed=`cat $CONFIG_FILE | grep LastMACUsed | cut -b 23- | tr -d '"'`

for iface in `ls /sys/class/net`; do
  read mac </sys/class/net/$iface/address

  mac=`echo $mac | tr -d ':'`
  if [ "${lastMACUsed#*$mac}" != "$lastMACUsed" ]; then
    echo "$iface -> $mac"
    #ip link set $iface down
    macchanger $iface -r
    #ip link set $iface up
  fi
done

rm -f "$CONFIG_FILE"

systemctl start teamviewerd
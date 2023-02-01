#!/bin/bash

if [ ! -d /var/log/Tink ]; then
  mkdir /var/log/Tink
fi

touch /var/log/Tink/PostInstallProxmox.sh

/usr/sbin/lvcreate -l 90%FREE -T cloud/data
/usr/sbin/pvesm add lvmthin local-lvm --vgname cloud --thinpool data

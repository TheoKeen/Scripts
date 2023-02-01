#!/bin/bash

if [ ! -d /var/log/Tink ]; then
  mkdir /var/log/Tink
fi

echo "frank ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

touch /var/log/Tink/PostInstallProxmox.sh

/usr/sbin/lvcreate -l 90%FREE -T cloud/data
/usr/sbin/pvesm add lvmthin local-lvm --vgname cloud --thinpool data

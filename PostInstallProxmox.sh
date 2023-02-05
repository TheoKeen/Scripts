#!/bin/bash

function PostInstall()
{
export DEBIAN_FRONTEND=noninteractive
apt-get -f install

if [ ! -d /var/log/Tink ]; then
  mkdir /var/log/Tink
fi

echo "frank ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

touch /var/log/Tink/PostInstallProxmox.sh

if [  -b /dev/nvme0n1p2 ]; then
zpool create -o ashift=13 -o autotrim=on pvedata /dev/nvme0n1p2
pvesm add zfspool --blocksize 64k pvedata -pool pvedata
fi

cp /home/frank/.ssh/authorized_keys /root/.ssh/

#/usr/sbin/lvcreate -l 90%FREE -T cloud/data
#/usr/sbin/pvesm add lvmthin local-lvm --vgname cloud --thinpool data
}

PostInstall  2>&1 | cat >> /var/log/TinkPostInstallProxmox.log

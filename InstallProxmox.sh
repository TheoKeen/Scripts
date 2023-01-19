#!/bin/bash

mv /etc/resolv.conf /etc/resolv.conf.bak
echo "nameserver 8.8.8.8" > /etc/resolv.conf

#hostnamectl set-hostname pve-tink01 --static
sed -i '3 i 172.18.4.200 pve-tink01' /etc/hosts

echo pve-tink01 > /etc/hostname

mkdir /run/network

cat << EOF > /etc/network/interfaces
auto lo
iface lo inet loopback

auto enp2s0
iface enp2s0 inet dhcp

EOF


apt install proxmox-ve postfix open-iscsi -y

mv /etc/resolv.conf.bak /etc/resolv.conf

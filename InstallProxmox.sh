#!/bin/bash

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

export DEBIAN_FRONTEND=noninteractive
apt install proxmox-ve -y


#!/bin/bash

Thostname=$(curl -s $TinkIP:50061/metadata | jq -r .metadata.instance.hostname)
Tip=$(curl -s $TinkIP:50061/metadata | jq  -r .network.interfaces[].dhcp.ip.address)

echo ${Thostname} > /root/hostname

#hostnamectl set-hostname pve-tink01 --static
sed -i "3 i ${Tip} ${Thostname}" /etc/hosts

echo ${Thostname} > /etc/hostname

mkdir /run/network

export DEBIAN_FRONTEND=noninteractive
apt install proxmox-ve -y

cat << EOF > /etc/network/interfaces.new
auto lo
iface lo inet loopback

auto enp2s0
iface enp2s0 inet dhcp

EOF


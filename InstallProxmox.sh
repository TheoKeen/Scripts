#!/bin/bash

if [  -b /dev/nvme0n1p2 ]; then

sgdisk -d 2 /dev/nvme0n1 
sgdisk -n 2:+10G /dev/nvme0n1
partprobe /dev/nvme0n1
growpart /dev/nvme0n1 1
pvresize /dev/nvme0n1p1
lvextend -l +100%FREE /dev/cloud/root
fi

apt-get install jq -y

Thostname=$(curl -s $TinkIP:50061/metadata | jq -r .metadata.instance.hostname)
Tip=$(curl -s $TinkIP:50061/metadata | jq  -r .network.interfaces[].dhcp.ip.address)
Tgateway=$(curl -s $TinkIP:50061/metadata | jq  -r .network.interfaces[].dhcp.ip.gateway)

sed -i "3 i ${Tip} ${Thostname}" /etc/hosts

echo ${Thostname} > /etc/hostname

mkdir /run/network

export DEBIAN_FRONTEND=noninteractive
dpkg-reconfigure openssh-server
apt install proxmox-ve -y

cat << EOF > /etc/network/interfaces.new
auto lo
iface lo inet loopback

iface enp2s0 inet manual

auto vmbr0
iface vmbr0 inet static
	address ${Tip}/24
	gateway ${Tgateway}
	bridge-ports enp2s0
	bridge-stp off
	bridge-fd 0
        bridge-vids 2-20
        bridge_vlan_aware yes
        bridge-access 4

EOF



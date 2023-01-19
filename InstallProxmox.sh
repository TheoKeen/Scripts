#!/bin/bash


hostnamectl set-hostname pve-tink01 --static
sed -i '3 i 10.240.0.20     pve-tink01' /etc/hosts

apt install proxmox-ve postfix open-iscsi- -y

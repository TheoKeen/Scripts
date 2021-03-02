#!/bin/bash

timedatectl set-timezone Europe/Amsterdam

apt-get update
apt install qemu-guest-agent -y

systemctl is-active --quiet qemu-guest-agent || systemctl start qemu-guest-agent

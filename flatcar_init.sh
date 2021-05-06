#!/bin/bash

#remove the symbolic link.
#rm ~/.bashrc

#create alias for docker-compose
echo alias docker-compose="'"'/usr/bin/docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$PWD:$PWD" \
    -w="$PWD" \
    docker/compose:1.29.0'"'" >> ~/.bashrc
    
shopt -s expand_aliases    
source ~/.bashrc

cd ~
git clone https://github.com/TheoKeen/docker-compose
cd ~/docker-compose/qemu-ga/
replace01=$(ls /dev/vport*)
search01="/dev/vport3p1"
sed -i "s,$search01,$replace01,g" ./docker-compose.yml

docker-compose up -d

mkdir /opt/keennews

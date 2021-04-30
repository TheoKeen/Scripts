#!/bin/bash

#remove the symbolic link.
rm ~/.bashrc

create alias for docker-compose
echo alias docker-compose="'"'docker run --rm \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v "$PWD:$PWD" \
    -w="$PWD" \
    docker/compose:1.29.0'"'" >> ~/.bashrc
    
source ~/.bashrc

cd ~
git clone https://github.com/TheoKeen/docker-compose
cd ~/docker-compose/qemu-ga/
docker-compose up -d

mkdir /opt/keennews

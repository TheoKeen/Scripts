#!/bin/bash

#remove the symbolic link.
#rm ~/.bashrc

cat << EOF > ~/.bashrc
if [ -d "/opt/usr/bin" ]; then
  PATH="$PATH:/opt/usr/bin"
fi
EOF

mkdir /opt/usr/bin -p
curl -L https://github.com/docker/compose/releases/download/1.25.3/docker-compose-`uname -s`-`uname -m` -o /opt/usr/bin/docker-compose
chmod +x /opt/usr/bin/docker-compose

source ~/.bashrc

cd ~
git clone https://github.com/TheoKeen/docker-compose
cd ~/docker-compose/qemu-ga/
replace01=$(ls /dev/vport*)
search01="/dev/vport3p1"
sed -i "s,$search01,$replace01,g" ./docker-compose.yml

docker-compose up -d

mkdir /opt/keennews

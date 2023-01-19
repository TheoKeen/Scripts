#!/bin/bash

if [ ! -d /var/log/Tink ]; then
  mkdir /var/log/Tink
fi

touch /var/log/Tink/PostInstallProxmox.sh

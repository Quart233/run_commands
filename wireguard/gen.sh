#!/bin/bash

read -p "Listen Port: " LISTEN_PORT
read -p "Static IP: " SITEIP
read -p "Porfile Name: " PROFILE

umask 077
PRIVATE=$(wg genkey)
echo $PRIVATE | tee $PROFILE.key | wg pubkey > $PROFILE.pub

cat << EOF | tee $PROFILE
[Interface]
PrivateKey = $PRIVATE
Address = $SITEIP
ListenPort = $LISTEN_PORT

EOF

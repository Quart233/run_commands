#!/bin/bash

read -p "Listen Port: " LISTEN_PORT
read -p "Static IP: " SITEIP
read -p "Porfile Name: " PROFILE_NAME

umask 077
PRIVATE=$(wg genkey)
echo $PRIVATE | tee $(hostname).key | wg pubkey > $(hostname).pub

cat << EOF | tee $PROFILE_NAME
[Interface]
PrivateKey = $PRIVATE
Address = $SITEIP
ListenPort = $LISTEN_PORT
EOF

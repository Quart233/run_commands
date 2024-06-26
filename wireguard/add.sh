#!/bin/bash

read -p "Hostname: " NAME
read -p "Public Key: " PUBKEY
read -p "Endpoint (IP:PORT): " ENDPOINT
read -p "Static IP: " SITEIP
read -p "Porfile: " PROFILE_NAME

cat << EOF | tee -a $PROFILE_NAME
[Peer]
# $NAME
PublicKey = $PUBKEY
AllowedIPs = $SITEIP
Endpoint = $ENDPOINT

EOF

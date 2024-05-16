#!/bin/bash

read -p "Listen Port: " LISTEN_PORT
read -p "Porfile Name: " PROFILE_NAME

umask 077
PRIVATE=$(wg genkey)
echo $PRIVATE | tee $(hostname).key | wg pubkey > $(hostname).pub

cat << EOF | tee $PROFILE_NAME
[Interface]
PrivateKey = $PRIVATE
Address = 10.10.11.1
ListenPort = $LISTEN_PORT

[Peer]
# beta site
PublicKey = <contents of /etc/wireguard/wgB.pub>
AllowedIPs = 10.10.11.2
Endpoint = <beta-gw-ip>:51000
EOF

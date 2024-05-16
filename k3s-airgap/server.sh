#!/bin/bash
read -p "External IP: " EXTERNALIP
read -p "Node IP: " NODEIP

# Copy files
mkdir -p /var/lib/rancher/k3s/agent/images
cp k3s-airgap-images-amd64.tar.zst /var/lib/rancher/k3s/agent/images
cp k3s /usr/local/bin/k3s
chmod a+x /usr/local/bin/k3s

export K3S_TOKEN=$(pwgen 25 1)
export INSTALL_K3S_SKIP_DOWNLOAD=true

curl -sfL https://get.k3s.io | sh -s - server \
    --cluster-init \
    --flannel-backend=wireguard-native \
    --flannel-iface=wg0 \
    --node-ip=$NODEIP \
    --advertise-address=$NODEIP \
    --node-external-ip=$EXTERNALIP \
    --tls-san=$EXTERNALIP # Optional, needed if using a fixed registration address

echo "K3S_TOKEN: $(tee token < $K3S_TOKEN)"
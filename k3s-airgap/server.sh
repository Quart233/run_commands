#!/bin/bash
echo "PublicIP:"
read PUBLIC_IP

echo "NodeIP:"
read NODE_IP

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
    --node-ip=$NODE_IP \
    --advertise-address=$NODE_IP \
    --node-external-ip=$PUBLIC_IP \
    --tls-san=$PUBLIC_IP # Optional, needed if using a fixed registration address

echo "K3S_TOKEN: $K3S_TOKEN"
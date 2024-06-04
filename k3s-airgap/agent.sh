#!/bin/bash
read -p "Node IP: " NODEIP
read -p "K3S_URL (https://<register-ip>:6443): " K3S_URL 
read -p "Token: " K3S_TOKEN

export K3S_URL
export K3S_TOKEN
export INSTALL_K3S_SKIP_DOWNLOAD=true

# Copy files
echo "Copying Files..."
mkdir -p /var/lib/rancher/k3s/agent/images
cp k3s-airgap-images-amd64.tar.zst /var/lib/rancher/k3s/agent/images
cp k3s /usr/local/bin/k3s
chmod a+x /usr/local/bin/k3s

curl -sfL https://get.k3s.io | sh -s - agent \
    --disable-apiserver-lb \
    --flannel-iface=wg0 \
    --node-ip=$NODEIP

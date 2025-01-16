#!/bin/bash
export INSTALL_K3S_SKIP_DOWNLOAD=true

read -p "Server: " K3S_SERVER
read -p "Token: " K3S_TOKEN

# Copy files
echo "Copying Files..."
mkdir -p /var/lib/rancher/k3s/agent/images
cp k3s-airgap-images-amd64.tar.zst /var/lib/rancher/k3s/agent/images
cp k3s /usr/local/bin/k3s
chmod a+x /usr/local/bin/k3s

curl -sfL https://get.k3s.io | sh -s - agent \
    --server="https://$K3S_SERVER:6443" \
    --token="$K3S_TOKEN"

#!/bin/bash
read -p "Cluster Init (yes/no): " answer
read -p "External IP: " EXTERNALIP

export INSTALL_K3S_SKIP_DOWNLOAD=true

# Copy files
echo "Copying Files..."
mkdir -p /var/lib/rancher/k3s/agent/images
cp k3s-airgap-images-amd64.tar.zst /var/lib/rancher/k3s/agent/images
cp k3s /usr/local/bin/k3s
chmod a+x /usr/local/bin/k3s

if [ "$answer" = "yes" ]; then
    curl -sfL https://get.k3s.io | sh -s - server \
        --tls-san=$EXTERNALIP # Optional, needed if using a fixed registration address

elif [ "$answer" = "no" ]; then
    read -p "K3S_URL (https://<register-ip>:6443): " K3S_URL 
    read -p "Token: " K3S_TOKEN
    curl -sfL https://get.k3s.io | sh -s - server \
else
    echo "Invalid input. Please enter 'yes' or 'no'."
    exit 0;
fi
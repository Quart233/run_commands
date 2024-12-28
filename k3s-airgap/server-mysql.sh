#!/bin/bash
read -p "External IP: " EXTERNALIP
read -p "Node IP: " NODEIP
read -p "K3S_DATASTORE_ENDPOINT: " K3S_DATASTORE_ENDPOINT
read -p "Cluster Init (yes/no): " answer

export INSTALL_K3S_SKIP_DOWNLOAD=true

# Copy files
echo "Copying Files..."
mkdir -p /var/lib/rancher/k3s/agent/images
cp k3s-airgap-images-amd64.tar.zst /var/lib/rancher/k3s/agent/images
cp k3s /usr/local/bin/k3s
chmod a+x /usr/local/bin/k3s

if [ "$answer" = "yes" ]; then
    export K3S_TOKEN=$(pwgen 25 1 | tee token)
    curl -sfL https://get.k3s.io | sh -s - server \
        --advertise-address=$NODEIP \
        --egress-selector-mode=disabled \
        --tls-san=$EXTERNALIP # Optional, needed if using a fixed registration address

    echo "K3S_TOKEN: $K3S_TOKEN"
elif [ "$answer" = "no" ]; then
    read -p "Token: " K3S_TOKEN
    export K3S_TOKEN
    curl -sfL https://get.k3s.io | sh -s - server \
        --advertise-address=$NODEIP \
        --egress-selector-mode=disabled \
else
    echo "Invalid input. Please enter 'yes' or 'no'."
    exit 0;
fi

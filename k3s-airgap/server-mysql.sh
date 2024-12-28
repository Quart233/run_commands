#!/bin/bash
read -p "Init (yes/no): " answer

export INSTALL_K3S_SKIP_DOWNLOAD=true

read -p "Node IP: " NODEIP
read -p "DB_HOSTNAME: " DB_HOSTNAME
read -p "DB_USERNAME: " DB_USERNAME
read -p "DB_PASSWORD: " DB_PASSWORD

# Copy files
echo "Copying Files..."
mkdir -p /var/lib/rancher/k3s/agent/images
cp k3s-airgap-images-amd64.tar.zst /var/lib/rancher/k3s/agent/images
cp k3s /usr/local/bin/k3s
chmod a+x /usr/local/bin/k3s

if [ "$answer" = "yes" ]; then
    read -p "External IP: " EXTERNALIP
    curl -sfL https://get.k3s.io | sh -s - server \
        --token=$(pwgen 25 1 | tee secret) \
        --datastore-endpoint="mysql://$DB_USERNAME:$DB_PASSWORD@tcp($DB_HOSTNAME:3306)/k3s" \
        --advertise-address=$NODEIP \
        --node-external-ip=$EXTERNALIP \
        --tls-san=$EXTERNALIP # Optional, needed if using a fixed registration address

    # Token
    cat /var/lib/rancher/k3s/server/token

elif [ "$answer" = "no" ]; then
    read -p "Token: " K3S_TOKEN
    curl -sfL https://get.k3s.io | sh -s - server \
        --token="$K3S_TOKEN" \
        --datastore-endpoint="mysql://$DB_USERNAME:$DB_PASSWORD@tcp($DB_HOSTNAME:3306)/k3s" \
        --node-external-ip=$EXTERNALIP \
        --advertise-address=$NODEIP
else
    echo "Invalid input. Please enter 'yes' or 'no'."
    exit 0;
fi

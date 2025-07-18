#!/bin/bash

# Inputs
NAME=$1
UUID=$2
STORAGE_CLASS=$3
HOSTNAME=$4

# Find the device path
DEVICE=$(blkid -U $UUID)
if [ -z "$DEVICE" ]; then
  echo "Device with UUID $UUID not found"
  exit 1
fi

# Get the size in bytes
SIZE_BYTES=$(blockdev --getsize64 $DEVICE)
SIZE_GI=$((SIZE_BYTES / 1024 / 1024 / 1024))Gi

# Generate PV YAML
cat <<EOF > pv.yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: $NAME
spec:
  capacity:
    storage: $SIZE_GI
  volumeMode: Filesystem
  accessModes:
    - ReadWriteOnce
  persistentVolumeReclaimPolicy: Retain
  storageClassName: $STORAGE_CLASS
  local:
    path: /dev/disk/by-uuid/$UUID
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - $HOSTNAME
EOF

# Apply the PV
kubectl apply -f pv.yaml
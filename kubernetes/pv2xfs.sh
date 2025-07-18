#!/bin/bash

# Script to convert an LVM PV to an XFS block device
# Usage: ./convert_lvm_to_xfs.sh <device> (e.g., /dev/sda)

# Check if device is provided as an argument
if [ -z "$1" ]; then
    echo "Error: No device specified."
    echo "Usage: $0 <device> (e.g., /dev/sda)"
    exit 1
fi

DEVICE="$1"

# Validate device existence
if [ ! -b "$DEVICE" ]; then
    echo "Error: Device $DEVICE does not exist or is not a block device."
    exit 1
fi

# Check if the device is an LVM PV
if ! pvdisplay "$DEVICE" >/dev/null 2>&1; then
    echo "Error: Device $DEVICE is not an LVM Physical Volume."
    exit 1
fi

# Get the VG name associated with the PV
VG_NAME=$(pvdisplay "$DEVICE" | grep "VG Name" | awk '{print $3}')
if [ -z "$VG_NAME" ]; then
    echo "Warning: No Volume Group found for $DEVICE. Proceeding to remove PV."
else
    echo "Found Volume Group: $VG_NAME"

    # Remove the VG
    echo "Removing Volume Group $VG_NAME..."
    if ! vgremove -f "$VG_NAME"; then
        echo "Error: Failed to remove Volume Group $VG_NAME."
        exit 1
    fi
fi

# Remove the PV
echo "Removing Physical Volume $DEVICE..."
if ! pvremove -f "$DEVICE"; then
    echo "Error: Failed to remove Physical Volume $DEVICE."
    exit 1
fi

# Initialize XFS filesystem on the device
echo "Creating XFS filesystem on $DEVICE..."
if ! mkfs.xfs -f "$DEVICE"; then
    echo "Error: Failed to create XFS filesystem on $DEVICE."
    exit 1
fi

# Get and display the UUID of the block device
echo "Retrieving UUID for $DEVICE..."
UUID=$(blkid -s UUID -o value "$DEVICE")
if [ -z "$UUID" ]; then
    echo "Error: Failed to retrieve UUID for $DEVICE."
    exit 1
else
    echo "Success: XFS filesystem created on $DEVICE with UUID: $UUID"
fi

exit 0
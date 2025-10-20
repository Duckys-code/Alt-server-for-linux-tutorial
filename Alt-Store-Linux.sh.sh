#!/bin/bash

echo "=== AltServer Linux Installer ==="
echo "Supported: Fedora / Debian / Ubuntu"
echo

# Detect distro
if [ -f /etc/fedora-release ]; then
    DISTRO="fedora"
elif [ -f /etc/debian_version ]; then
    DISTRO="debian"
else
    echo "Unsupported distribution. Exiting."
    exit 1
fi

# Step 1: Create sideloading dir
mkdir -p ~/Desktop/Sideloading
cd ~/Desktop/Sideloading || exit

# Step 2: Install dependencies
echo "Installing dependencies..."
if [ "$DISTRO" = "fedora" ]; then
    sudo dnf install -y python3 python3-pip git usbmuxd libimobiledevice ifuse fuse wget unzip curl
else
    sudo apt update
    sudo apt install -y python3 python3-pip git usbmuxd libimobiledevice6 ifuse wget unzip curl
fi

# Step 3: Install pymobiledevice3
pip install -U pymobiledevice3

# Step 4: Clone AltServer-Linux
if [ ! -d "AltServer-Linux" ]; then
    git clone https://github.com/NyaMisty/AltServer-Linux.git
fi
cd AltServer-Linux || exit
chmod +x AltServer
cd ..

# Step 5: UUID detection
echo
read -rp "Do you know your device UUID? (y/n): " uuid_known
if [ "$uuid_known" = "y" ]; then
    read -rp "Enter your device UUID: " DEVICE_UUID
else
    echo "Detecting UUID..."
    DEVICE_UUID=$(idevice_id -l | head -n 1)
    echo "Detected UUID: $DEVICE_UUID"
fi

# Step 6: Apple credentials
read -rp "Enter your Apple ID email: " APPLE_ID
read -rp "Enter your app-specific password: " APP_PASS

# Step 7: Choose Anisette server
echo
echo "Select Anisette Server:"
echo "1) https://ani.sidestore.io"
echo "2) https://ani.altstore.io"
echo "3) https://ani.sidestore.dev"
echo "4) https://anisette.ra1nusb.com"
echo "5) https://ani.otheralt.io"
read -rp "Choice (1-5): " SERVER_CHOICE

case $SERVER_CHOICE in
    1) SERVER="https://ani.sidestore.io" ;;
    2) SERVER="https://ani.altstore.io" ;;
    3) SERVER="https://ani.sidestore.dev" ;;
    4) SERVER="https://anisette.ra1nusb.com" ;;
    5) SERVER="https://ani.otheralt.io" ;;
    *) echo "Invalid choice, using default (sidestore.io)"; SERVER="https://ani.sidestore.io" ;;
esac

# Step 8: DNS Fix
echo "Applying DNS fix..."
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

# Step 9: Get IPA path
read -rp "Enter the path to your .ipa file: " IPA_PATH

# Step 10: Run sideload command
cd AltServer-Linux || exit
echo
echo "Sideloading app..."
ALTSERVER_ANISETTE_SERVER="$SERVER" ./Alt -u "$DEVICE_UUID" -a "$APPLE_ID" -p "$APP_PASS" "$IPA_PATH"

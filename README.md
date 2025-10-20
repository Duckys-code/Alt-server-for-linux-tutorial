# Alt-server-for-linux-tutorial
Hi so I wanted to sideload but I have fedora and couldnt find anything that worked so I made a solution I'm going to get this working for Fedora/Debian base distros and if anyone wants to help me expand to other distros just make a comment! Either way here we GO!


# === iOS App Sideloading on Linux (Fedora/Debian) ===
# This tutorial sets up AltServer-Linux and allows sideloading IPAs without Xcode or macOS.

# =====================================================
# 1. Create Sideloading Directory
# =====================================================
mkdir -p ~/Desktop/Sideloading
cd ~/Desktop/Sideloading

# =====================================================
# 2. Install Dependencies
# =====================================================
# Fedora:
sudo dnf install -y python3 python3-pip git usbmuxd libimobiledevice ifuse fuse wget unzip curl

# Debian/Ubuntu:
sudo apt update
sudo apt install -y python3 python3-pip git usbmuxd libimobiledevice6 ifuse wget unzip curl

# =====================================================
# 3. Install pymobiledevice3
# =====================================================
pip install -U pymobiledevice3

# =====================================================
# 4. Install and Set Up AltServer-Linux
# =====================================================
git clone https://github.com/NyaMisty/AltServer-Linux.git
cd AltServer-Linux
chmod +x AltServer

# =====================================================
# 5. Test Connection to iPhone
# =====================================================
# Make sure your device is connected via USB and trusted.
idevice_id -l

# The output will look like:
# 00008101xxxxxxxxxxxxxxxxx
# That is your UUID.

# =====================================================
# 6. Get an App-Specific Password
# =====================================================
# Log into https://appleid.apple.com
# Go to “App-Specific Passwords” → “Generate Password”
# Save it — you’ll use it as your -p argument.

# =====================================================
# 7. Choose an Anisette Server
# =====================================================
# Choose one of the following (you’ll pick one later):
# 1. https://ani.sidestore.io
# 2. https://ani.altstore.io
# 3. https://ani.sidestore.dev
# 4. https://anisette.ra1nusb.com
# 5. https://ani.otheralt.io

# =====================================================
# 8. Fix DNS if needed (recommended before sideload)
# =====================================================
echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf > /dev/null

# =====================================================
# 9. Sideloading the IPA
# =====================================================
# Syntax:
# ALTSERVER_ANISETTE_SERVER="<anisette_url>" ./Alt -u <uuid> -a <apple_id> -p "<app_password>" <ipa_file>

# Example:
# ALTSERVER_ANISETTE_SERVER="https://ani.sidestore.io" ./Alt -u 00008101xxxxxxxxxxxx -a "example@gmail.com" -p "abcd-efgh-ijkl-mnop" app.ipa

# =====================================================
# 10. Verify Installation
# =====================================================
# Check your device — the app should appear.
# If it doesn’t open, make sure the certificate hasn’t expired.


# === Automated iOS Sideloading Setup for Linux ===
# This uses Alt-Store-Linux.sh to install everything automatically.

# =====================================================
# 1. Download the installer
# =====================================================
wget https://github.com/Duckys-code/Alt-server-for-linux-tutorial Alt-Store-Linux.sh -O Alt-Store-Linux.sh

# =====================================================
# 2. Give execute permission
# =====================================================
chmod +x Alt-Store-Linux.sh

# =====================================================
# 3. Run the installer
# =====================================================
./Alt-Store-Linux.sh

# The script will:
# - Detect your distro (Fedora/Debian)
# - Install dependencies
# - Install AltServer-Linux
# - Ask for your UUID, Apple ID, and password
# - Let you pick an Anisette server
# - Fix DNS if needed
# - Ask for your IPA file path and sideload it

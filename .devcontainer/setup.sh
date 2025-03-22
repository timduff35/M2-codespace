#!/bin/bash
set -e  # Stop on error

echo "========== STARTING SETUP =========="

echo "Updating package lists..."
sudo apt update

echo "Installing dependencies..."
sudo apt install -y software-properties-common curl

echo "Adding Macaulay2 PPA..."
sudo add-apt-repository -y ppa:macaulay2/macaulay2
sudo apt update

echo "Installing Macaulay2..."
sudo apt install -y macaulay2

echo "Creating symlink to /usr/local/bin/M2..."
M2_PATH=$(command -v M2)
if [ "$M2_PATH" != "/usr/local/bin/M2" ]; then
    sudo ln -sf "$M2_PATH" /usr/local/bin/M2
    echo "Symlink created: /usr/local/bin/M2 → $M2_PATH"
else
    echo "M2 is already in /usr/local/bin"
fi


echo "Verifying Macaulay2 installation..."
if command -v M2 &>/dev/null; then
    echo "✅ Macaulay2 installed successfully!"
    M2 --version
else
    echo "❌ ERROR: Macaulay2 installation failed!"
    exit 1
fi

echo "=== Passed Macaulay2 check. Installing VS Code CLI... ==="

echo "========== SETUP COMPLETE =========="

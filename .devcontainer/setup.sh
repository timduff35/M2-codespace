#!/bin/bash
set -e  # Stop on error

echo "Updating package lists..."
sudo apt update

echo "Installing dependencies..."
sudo apt install -y software-properties-common

echo "Adding Macaulay2 PPA..."
sudo add-apt-repository -y ppa:macaulay2/macaulay2
sudo apt update

echo "Installing Macaulay2..."
sudo apt install -y macaulay2

echo "Verifying Macaulay2 installation..."
M2 --version || { echo "Macaulay2 installation failed"; exit 1; }

echo "Setup complete!"

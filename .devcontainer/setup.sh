#!/bin/bash
set -e  # Stop on error

echo "========== STARTING SETUP =========="

echo "Updating package lists..."
sudo apt -y update

echo "Installing dependencies..."
sudo apt install -y software-properties-common curl

echo "Adding Macaulay2 PPA..."

echo "postfix postfix/main_mailer_type select No configuration" | sudo debconf-set-selections
echo "postfix postfix/mailname string localhost" | sudo debconf-set-selections

sudo add-apt-repository -y ppa:macaulay2/macaulay2
sudo apt -y update
sudo DEBIAN_FRONTEND=noninteractive apt install -y macaulay2 

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

# Install VS Code extensions
echo "Installing Macaulay2 VS Code extension..."
code --install-extension "coreysharris.macaulay2" || echo "Extension install failed, continuing..."

# Set Macaulay2 executable path in VS Code settings
echo "Configuring Macaulay2 extension..."
M2_PATH=$(command -v M2)

mkdir -p /home/vscode/.config/Code/User/
cat <<EOL > /home/vscode/.config/Code/User/settings.json
{
  "macaulay2.executablePath": "$M2_PATH"
}
EOL

# Ensure correct ownership (only needed for Codespaces)
sudo chown -R vscode:vscode /home/vscode/.config

echo "Setup complete!"

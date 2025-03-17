#!/bin/bash
set -e  # Stop on error

echo "========== STARTING SETUP =========="

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
if command -v M2 &>/dev/null; then
    echo "✅ Macaulay2 installed successfully!"
    M2 --version
else
    echo "❌ ERROR: Macaulay2 installation failed!"
    exit 1
fi

# Debugging: Ensure the script continues beyond Macaulay2 check
echo "=== Passed Macaulay2 check. Proceeding to VS Code extension installation... ==="

# Debugging: Check if VS Code CLI is available
echo "Checking if VS Code CLI (code) is available..."
if command -v code &>/dev/null; then
    echo "✅ VS Code CLI found!"
else
    echo "❌ ERROR: VS Code CLI (code) not found. Extension installation will fail!"
    exit 1
fi

# Install VS Code extensions
echo "Installing Macaulay2 VS Code extension..."
code --install-extension coreysharris.macaulay2 || echo "⚠️ WARNING: Extension install failed, continuing..."

# Debugging: Verify installed extensions
echo "Checking installed VS Code extensions..."
code --list-extensions | grep "coreysharris.macaulay2" && echo "✅ Macaulay2 extension installed!" || echo "⚠️ WARNING: Macaulay2 extension NOT installed!"

# Set Macaulay2 executable path in VS Code settings
echo "Configuring Macaulay2 extension..."
M2_PATH=$(command -v M2)

echo "Macaulay2 executable path detected: $M2_PATH"

mkdir -p /home/vscode/.config/Code/User/
cat <<EOL > /home/vscode/.config/Code/User/settings.json
{
  "macaulay2.executablePath": "$M2_PATH"
}
EOL

# Ensure correct ownership (only needed for Codespaces)
sudo chown -R vscode:vscode /home/vscode/.config

echo "========== SETUP COMPLETE =========="

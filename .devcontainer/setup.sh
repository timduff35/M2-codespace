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

echo "Verifying Macaulay2 installation..."
if command -v M2 &>/dev/null; then
    echo "✅ Macaulay2 installed successfully!"
    M2 --version
else
    echo "❌ ERROR: Macaulay2 installation failed!"
    exit 1
fi  # <- this was missing!

echo "⚠️  For best compatibility, disable VS Code Settings Sync."
echo "   Run: Ctrl+Shift+P → 'Settings Sync: Turn Off'"

# Optional check (may not work in Codespaces)
# Optional check (may not work in Codespaces)
expected_path="/usr/bin/M2"
actual_path=$(code --show-versions 2>/dev/null | grep "macaulay2.executablePath")

echo "🔍 Expected Macaulay2 path: $expected_path"
echo "🔍 Detected Macaulay2 path from VS Code settings (if available):"
echo "$actual_path"

if [[ "$actual_path" != *"$expected_path"* ]]; then
  echo "⚠️  Detected possible mismatch in Macaulay2 executable path."
  echo "   VS Code may be applying your personal settings."
  echo "   Please disable Settings Sync to ensure repo settings are used."
fi

echo "========== SETUP COMPLETE =========="

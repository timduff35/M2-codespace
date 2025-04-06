#!/bin/bash

echo "🔍 Checking Macaulay2 executable path in .vscode/settings.json..."

expected_path="/usr/bin/M2"
settings_file=".vscode/settings.json"

if [[ ! -f "$settings_file" ]]; then
  echo "❌ settings.json not found at $settings_file"
  exit 1
fi

actual_path=$(grep -m1 "macaulay2.executablePath" "$settings_file")

echo "📌 Expected path: $expected_path"
echo "📌 Found setting: $actual_path"

if [[ "$actual_path" == *"$expected_path"* ]]; then
  echo "✅ Macaulay2 path appears correctly set."
else
  echo "⚠️  Path may be incorrect. VS Code might be applying your personal settings."
  echo "👉 Turn off Settings Sync: Ctrl+Shift+P → 'Settings Sync: Turn Off'"
fi

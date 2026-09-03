#!/bin/bash
# install_dependencies.sh
# Installs libgdiplus and libc6-dev, required by RAPTOR Avalonia on Linux

set -e

echo "==> Updating package lists..."
sudo apt update

echo "==> Installing libgdiplus and libc6-dev..."
sudo apt install -y libgdiplus libc6-dev

echo "==> Done. Dependencies installed."

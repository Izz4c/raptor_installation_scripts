#!/bin/bash
# install_dotnet8.sh
# Installs the .NET 8.0 Runtime on Ubuntu

set -e

echo "==> Updating package lists..."
sudo apt update

echo "==> Attempting install via apt (dotnet-runtime-8.0)..."
if sudo apt install -y dotnet-runtime-8.0; then
    echo "==> .NET 8.0 Runtime installed successfully via apt."
else
    echo "==> apt install failed or package not found. Falling back to Microsoft's official install script..."
    wget https://dot.net/v1/dotnet-install.sh -O dotnet-install.sh
    chmod +x dotnet-install.sh
    ./dotnet-install.sh --channel 8.0 --runtime dotnet
    rm dotnet-install.sh

    echo "==> Add the following to your ~/.bashrc if not already present:"
    echo '    export DOTNET_ROOT=$HOME/.dotnet'
    echo '    export PATH=$PATH:$HOME/.dotnet'
fi

echo "==> Verifying installation..."
dotnet --list-runtimes || echo "dotnet command not found on PATH. You may need to restart your terminal or update your PATH."

echo "==> Done."

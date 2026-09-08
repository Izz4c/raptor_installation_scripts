#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

echo "=== Raptor Avalonia Linux Fix Script ==="

#Locate system libc.so.6 library
LIBC_PATH=$(ldconfig -p | grep "libc.so.6" | awk '{print $NF}' | head -n 1)

if [ -z "$LIBC_PATH" ]; then
  echo "Error: Could not automatically locate libc.so.6 on your system."
  exit 1
fi

TARGET_DIR=$(dirname "$LIBC_PATH")
SYMLINK_PATH="$TARGET_DIR/libdl.so"

echo "[1/2] Creating libdl.so symlink pointing to $LIBC_PATH..."

if [ -f "$SYMLINK_PATH" ] || [ -L "$SYMLINK_PATH" ]; then
  echo "Notice: $SYMLINK_PATH already exists. Refreshing link..."
  rm -f "$SYMLINK_PATH"
fi

ln -s "$LIBC_PATH" "$SYMLINK_PATH"

# Enable System.Drawing Unix support in runtimeconfig if local directory is detected
echo "[3/3] Checking for raptor.runtimeconfig.json..."

CONFIG_FILE="raptor.runtimeconfig.json"
if [ -f "$CONFIG_FILE" ]; then
  if ! grep -q "System.Drawing.EnableUnixSupport" "$CONFIG_FILE"; then
    echo "Adding System.Drawing.EnableUnixSupport runtime switch..."
    # Simple JSON injection before closing options
    sed -i 's/"configProperties": {/"configProperties": {\n      "System.Drawing.EnableUnixSupport": true,/g' "$CONFIG_FILE"
  fi
fi

echo "=== Fix completed successfully! ==="
echo "You can now run your application using: dotnet raptor.dll"

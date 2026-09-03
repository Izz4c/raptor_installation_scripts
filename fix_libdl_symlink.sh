#!/bin/bash
# fix_libdl_symlink.sh
# Fixes the "Unable to load shared library 'libdl'" error some users hit
# when running RAPTOR Avalonia (or other apps) via dotnet on Linux.

set -e

echo "==> Checking for libdl.so.2 and creating symlinks if needed..."

if [ -f /usr/lib/libdl.so.2 ] && [ ! -f /usr/lib/libdl.so ]; then
    sudo ln -s /usr/lib/libdl.so.2 /usr/lib/libdl.so
    echo "    Created /usr/lib/libdl.so -> /usr/lib/libdl.so.2"
else
    echo "    /usr/lib/libdl.so already exists or libdl.so.2 not found at that path, skipping."
fi

if [ -f /usr/lib64/libdl.so.2 ] && [ ! -f /usr/lib64/libdl.so ]; then
    sudo ln -s /usr/lib64/libdl.so.2 /usr/lib64/libdl.so
    echo "    Created /usr/lib64/libdl.so -> /usr/lib64/libdl.so.2"
else
    echo "    /usr/lib64/libdl.so already exists or libdl.so.2 not found at that path, skipping."
fi

echo "==> Done. Try running your dotnet app again."

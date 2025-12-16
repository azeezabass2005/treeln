#!/bin/bash
set -e

REPO="azeezabass2005/treeln"
BIN="$HOME/.local/bin/treeln"

OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)
[ "$ARCH" = "x86_64" ] || [ "$ARCH" = "amd64" ] && ARCH="x86_64"

URL=$(curl -s https://api.github.com/repos/$REPO/releases/latest | grep browser_download_url | grep "$OS-$ARCH" | cut -d '"' -f 4)

mkdir -p "$(dirname "$BIN")"
curl -sL "$URL" -o "$BIN"
chmod +x "$BIN"

echo "treeln installed"

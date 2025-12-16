#!/bin/bash
set -e

REPO="azeezabass2005/treeln"
BIN_DIR="$HOME/.local/bin"

# Detect OS and architecture
OS=$(uname -s | tr '[:upper:]' '[:lower:]')
ARCH=$(uname -m)

case "$OS" in
  linux*) OS="linux" ;;
  darwin*) OS="macos" ;;
  *) echo "Error: Unsupported OS: $OS"; exit 1 ;;
esac

case "$ARCH" in
  x86_64|amd64) ARCH="x86_64" ;;
  aarch64|arm64) ARCH="aarch64" ;;
  *) echo "Error: Unsupported architecture: $ARCH"; exit 1 ;;
esac

echo "Detected: $OS $ARCH"

# Get latest release tag
LATEST_TAG=$(curl -s "https://api.github.com/repos/$REPO/releases/latest" | grep '"tag_name":' | sed -E 's/.*"([^"]+)".*/\1/')

if [ -z "$LATEST_TAG" ]; then
  echo "Error: Failed to fetch latest release"
  exit 1
fi

echo "Installing treeln $LATEST_TAG..."

# Construct download URL
BINARY_NAME="treeln-${OS}-${ARCH}"
URL="https://github.com/$REPO/releases/download/$LATEST_TAG/${BINARY_NAME}.tar.gz"

echo "Downloading from: $URL"

# Create bin directory if it doesn't exist
mkdir -p "$BIN_DIR"

# Download and extract
curl -sL "$URL" | tar xz -C "$BIN_DIR"

if [ $? -ne 0 ]; then
  echo "Error: Download or extraction failed"
  exit 1
fi

# Make executable
chmod +x "$BIN_DIR/treeln"

echo "✓ treeln installed to $BIN_DIR/treeln"

# Check if BIN_DIR is in PATH
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
  echo ""
  echo "Warning: $BIN_DIR is not in your PATH"
  echo "Add this line to your ~/.bashrc or ~/.zshrc:"
  echo "  export PATH=\"\$PATH:$BIN_DIR\""
  echo ""
  echo "Then run: source ~/.bashrc  (or ~/.zshrc)"
else
  echo "✓ Ready to use! Run 'treeln --help' to get started"
fi
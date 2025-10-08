#!/usr/bin/env bash

set -e

echo "=== Nix Home Manager Setup ==="
echo

# Check if Nix is installed
if ! command -v nix &>/dev/null; then
  echo "Nix is not installed. Installing Nix..."
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install --determinate

  # Source nix profile
  if [ -f /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh ]; then
    . /nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh
  fi

  echo "Nix installed successfully!"
  echo
else
  echo "Nix is already installed."
  echo
fi

# Detect architecture
ARCH=$(uname -m)
case "$ARCH" in
x86_64)
  ARCH_NAME="x86"
  ;;
aarch64 | arm64)
  ARCH_NAME="arm"
  ;;
*)
  echo "Unsupported architecture: $ARCH"
  exit 1
  ;;
esac

# Detect OS
OS=$(uname -s)
case "$OS" in
Linux)
  OS_NAME="linux"
  ;;
Darwin)
  OS_NAME="darwin"
  ;;
*)
  echo "Unsupported OS: $OS"
  exit 1
  ;;
esac

echo "Detected: $ARCH_NAME / $OS_NAME"
echo

# Clear any remaining input and prompt for user
read -t 0.1 -n 10000 discard 2>/dev/null || true
echo "Select user:"
echo "1) root"
read -p "Enter choice [1]: " USER_CHOICE
USER_CHOICE=${USER_CHOICE:-1}

case "$USER_CHOICE" in
1)
  USER_NAME="root"
  ;;
*)
  echo "Invalid choice. Defaulting to root."
  USER_NAME="root"
  ;;
esac

# Build flake configuration name
FLAKE_CONFIG="${USER_NAME}_${ARCH_NAME}_${OS_NAME}"

echo
echo "Configuration: $FLAKE_CONFIG"
echo "Running Home Manager..."
echo

# Run home-manager
nix run home-manager/master -- switch --flake "github:cupcakearmy/nix?dir=cli#${FLAKE_CONFIG}" -b backup

echo
echo "=== Setup complete! ==="

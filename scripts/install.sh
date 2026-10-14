#!/bin/zsh
# install.sh — install shared Node + Hyperframes CLI on Art 2
set -euo pipefail

AGENTS_DIR="$(cd "$(dirname "$0")/.." && pwd)"
ROOT="$(cd "$AGENTS_DIR/.." && pwd)"
NODE_DIR="$ROOT/.node"

check_only=false
if [[ "${1:-}" == "--check" ]]; then
  check_only=true
fi

echo "=== Art 2 Agent Tooling Check ==="

# Affinity
if [[ -d /Applications/Affinity.app ]]; then
  echo "Affinity: OK (/Applications/Affinity.app)"
else
  echo "Affinity: MISSING — install Affinity 3 unified app from Serif or the Mac App Store."
fi

# Node
if [[ -x "$NODE_DIR/bin/node" ]]; then
  echo "Node: OK ($($NODE_DIR/bin/node --version))"
else
  if $check_only; then
    echo "Node: MISSING (run install.sh without --check to install)"
  else
    echo "Node: installing into $NODE_DIR ..."
    mkdir -p "$NODE_DIR"
    # Download latest Node 22 LTS for macOS arm64
    NODE_VERSION="v22.23.3"
    NODE_TARBALL="node-${NODE_VERSION}-darwin-arm64.tar.gz"
    NODE_URL="https://nodejs.org/dist/${NODE_VERSION}/$NODE_TARBALL"
    curl -fsSL "$NODE_URL" -o "/tmp/$NODE_TARBALL"
    tar -xzf "/tmp/$NODE_TARBALL" -C /tmp
    cp -R "/tmp/node-${NODE_VERSION}-darwin-arm64"/* "$NODE_DIR/"
    rm -rf "/tmp/$NODE_TARBALL" "/tmp/node-${NODE_VERSION}-darwin-arm64"
    echo "Node: installed ($($NODE_DIR/bin/node --version))"
  fi
fi

# Hyperframes CLI
if [[ -x "$NODE_DIR/bin/hyperframes" ]]; then
  echo "Hyperframes: OK ($($NODE_DIR/bin/hyperframes --version 2>/dev/null || echo 'version check failed'))"
else
  if $check_only; then
    echo "Hyperframes: MISSING (run install.sh without --check to install)"
  else
    echo "Hyperframes: installing ..."
    export PATH="$NODE_DIR/bin:$PATH"
    npm install -g hyperframes@latest
    echo "Hyperframes: installed"
  fi
fi

echo "=== Done ==="
echo "Source $AGENTS_DIR/bin/activate to put tools on PATH."

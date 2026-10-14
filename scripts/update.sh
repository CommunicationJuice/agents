#!/bin/zsh
# update.sh — keep agents and all submodules up to date
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
LOG_DIR="/Users/Shared/Agents/var/log"
mkdir -p "$LOG_DIR"
LOG="$LOG_DIR/agents-update.log"

echo "[$(date -Iseconds)] Starting agents update" >> "$LOG"

export GIT_SSH_COMMAND="ssh -F /Users/Shared/Agents/.ssh/config -o IdentitiesOnly=yes"

cd "$ROOT"

# Pull the umbrella repo first
git pull origin main >> "$LOG" 2>&1 || {
  echo "[$(date -Iseconds)] ERROR: agents git pull failed" >> "$LOG"
  exit 1
}

# Update submodules
git submodule update --init --recursive --remote >> "$LOG" 2>&1 || {
  echo "[$(date -Iseconds)] ERROR: submodule update failed" >> "$LOG"
  exit 1
}

echo "[$(date -Iseconds)] Update complete" >> "$LOG"

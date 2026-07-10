#!/usr/bin/env bash
# 521 — local preview. Port 8521 per ../PORTS.md (the port authority).
set -euo pipefail
cd "$(dirname "$0")"
PORT="${PORT:-8521}"
echo "521 → http://localhost:${PORT}"
exec python3 -m http.server "${PORT}" --bind 127.0.0.1

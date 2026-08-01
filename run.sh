#!/usr/bin/env bash
# 521 — local preview. Port 8521 per ../PORTS.md (the port authority).
set -euo pipefail
cd "$(dirname "$0")"
PORT="${PORT_521:-${PORT:-8521}}"   # bin/521 exports PORT; PORT_521 is its own name
echo "521 → http://localhost:${PORT}"
exec python3 -m http.server "${PORT}" --bind 127.0.0.1

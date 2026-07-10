#!/usr/bin/env bash
# 521 — headless end-to-end test of the full 5→2→1 loop (_smoke.html).
# Starts a temporary server on the port if nothing is listening.
set -uo pipefail
cd "$(dirname "$0")"
PORT="${PORT:-8521}"
CHROME="/Applications/Google Chrome.app/Contents/MacOS/Google Chrome"
STARTED=""
if ! lsof -nP -i ":$PORT" >/dev/null 2>&1; then
  python3 -m http.server "$PORT" --bind 127.0.0.1 >/dev/null 2>&1 &
  STARTED=$!
  sleep 0.5
fi
DOM="$(mktemp)"
"$CHROME" --headless=new --disable-gpu --dump-dom --virtual-time-budget=20000 \
  "http://localhost:$PORT/_smoke.html" >"$DOM" 2>/dev/null
python3 - "$DOM" <<'PY'
import sys, html, re
dom = open(sys.argv[1]).read()
m = re.search(r'<pre id="out">(.*?)</pre>', dom, re.S)
if not m or not m.group(1).strip():
    print('=== FAILURE: smoke page produced no output')
    sys.exit(1)
out = html.unescape(m.group(1))
print(out)
fails = [l for l in out.splitlines() if l.startswith(('FAIL', 'ERROR'))]
print('===', 'ALL PASS' if not fails else f'{len(fails)} FAILURES')
sys.exit(1 if fails else 0)
PY
RC=$?
rm -f "$DOM"
[ -n "$STARTED" ] && kill "$STARTED" 2>/dev/null
exit $RC

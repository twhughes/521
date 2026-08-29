#!/usr/bin/env bash
# Plot & Wash — headless smoke test. Loads index.html#smoke, which runs the
# in-page checks (all generators, ink pixels, SVG export, paint, undo) and
# writes results into <pre id="out">.
set -uo pipefail
cd "$(dirname "$0")"
PORT="${PORT:-8180}"

CHROME=""
for c in "${CHROME_BIN:-}" \
         "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
         chromium chromium-browser google-chrome; do
  [ -n "${c:-}" ] || continue
  if command -v "$c" >/dev/null 2>&1 || [ -x "$c" ]; then CHROME="$c"; break; fi
done 2>/dev/null
[ -n "$CHROME" ] || { echo "no Chrome/Chromium found (set CHROME_BIN)"; exit 1; }

STARTED=""
if ! lsof -nP -i ":$PORT" >/dev/null 2>&1; then
  python3 -m http.server "$PORT" --bind 127.0.0.1 >/dev/null 2>&1 &
  STARTED=$!
  sleep 0.5
fi
DOM="$(mktemp)"
"$CHROME" --headless=new --disable-gpu ${CHROME_FLAGS:-} --dump-dom --virtual-time-budget=15000 \
  "http://localhost:$PORT/index.html#smoke" >"$DOM" 2>/dev/null
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

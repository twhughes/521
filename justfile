# 521 — port 8521 per ../PORTS.md
port := "8521"

# serve the app locally
run:
    @echo "521 → http://localhost:{{port}}"
    python3 -m http.server {{port}} --bind 127.0.0.1

# headless end-to-end test of the full 5→2→1 loop
test:
    ./test.sh

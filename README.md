# 521 — list 5 · keep 2 · pick 1

The two-person decision ritual as a tiny web app. One person lists five options,
the other keeps their favorite two, the lister picks the winner — then tells them.
Every turn travels as a link you text each other; there is no backend at all.

## Run it

```sh
./run.sh          # serves on http://localhost:8521  (port per ../PORTS.md)
just run          # same, once `just` is installed
./test.sh         # headless end-to-end test of the whole loop (_smoke.html)
```

## How it works

- The whole round — title, names, options, picks — is JSON, base64url-encoded
  into the URL **hash fragment**. Fragments never reach a server, so even hosted,
  no round data is ever logged anywhere.
- Each stage renders from the link and produces the next link:
  `home (list 5)` → `#…cut (keep 2)` → `#…close (pick 1)` → `#…done (🏆)`.
- Share button uses the native iOS share sheet (falls back to clipboard).
- localStorage keeps only your own name, partner name (for the coin flip),
  and the last 12 rounds. Nothing else, nowhere else.

## Deploy

**Live at https://tylerwhughes.com/521/** (GitHub Pages, `twhughes/521`, branch `main`).
Any static host works — it's one `index.html` with zero dependencies.
The repo holds only generic app code; round data exists only in the links people text each other.

## Lineage

Supersedes `../521_backup/` (Jan 2025): kept its one great idea
(state-in-URL, zero backend), rebuilt the protocol, UI, and sharing from scratch.

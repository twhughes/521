# Plot & Wash

A pocket workstation for pen-plotter generative art, built to test the whole
loop before buying a machine: **generate black-and-white line art → preview →
watercolor over it with a finger → save**.

One self-contained `index.html`, zero dependencies, designed for the phone.

## What it does

- **Plot** — four seeded vector line generators, each with live sliders and a
  ↻ new-seed dice roll:
  - **Field** — lines advected through a noise flow field
  - **Pendulum** — a damped harmonograph (two detuned pendulums per axis)
  - **Ridges** — stacked ridgelines with real hidden-line occlusion
  - **Rotor** — one wobbly closed curve repeated with incremental twist,
    shrink, and drift (rotation/extrusion)
- **Wash** — finger-paint watercolor over the ink: nine pigments, brush and
  water sliders, lift (eraser), undo. Paint multiply-blends over the lines the
  way transparent watercolor sits on waterproof fineliner.
- **Export** — `SVG` writes true polylines scaled to A4 millimetres, ready for
  an AxiDraw / NextDraw / iDraw via Inkscape or vpype. `PNG` saves the finished
  painted piece. Params and seeds persist in `localStorage`.

## Run it

```sh
python3 -m http.server 8080   # then open http://localhost:8080
./test.sh                     # headless smoke test (#smoke hash hook)
```

Opening `index.html` straight from disk works too.

## The physical loop this rehearses

1. Generate lines here, export SVG.
2. Plot with a waterproof fineliner (Micron / Copic Multiliner) on watercolor paper.
3. Hand-paint washes over the plotted ink.

Prior art worth studying: Licia He's plotter watercolor paintings and her
*Painting With Plotters* course; the awesome-plotters list; drawingbots.net.

## History

Started life on a branch of `twhughes/521` (the only repo reachable from a
phone session); this branch carries its own orphan history so it can become
its own repository unchanged.

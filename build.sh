#!/usr/bin/env bash
# Reproducible build with the TeX Live version of the original submission (Overleaf, Nov 2020 = TeX Live 2019).
# Requires podman (or docker: export ENGINE=docker). Output: build/vinci_2020_19.pdf
# openout_any=a: this latexmk runs bibtex from /src with an absolute -outdir, which bibtex refuses by default.
set -euo pipefail
cd "$(dirname "$0")"
ENGINE=${ENGINE:-podman}
IMAGE=docker.io/texlive/texlive:TL2019-historic
mkdir -p build
"$ENGINE" run --rm -e openout_any=a -v "$PWD/src:/src:ro,Z" -v "$PWD/build:/out:Z" -w /src "$IMAGE" \
  latexmk -pdf -interaction=nonstopmode -outdir=/out vinci_2020_19.tex

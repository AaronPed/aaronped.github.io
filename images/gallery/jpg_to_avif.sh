#!/usr/bin/env bash

set -euo pipefail

SRC="/Users/aaronpedersen/Downloads/Photos-3-001"
SIZES=(1200 800 400)

shopt -s nullglob

for img in "$SRC"/*.jpg "$SRC"/*.JPG; do
  base="$(basename "$img")"
  name="${base%.*}"

  echo "Converting $base → $name.avif"

  ffmpeg -y -loglevel error \
    -i "$img" \
    -c:v libaom-av1 \
    -still-picture 1 \
    -crf 30 \
    -b:v 0 \
    "$name.avif"

  for w in "${SIZES[@]}"; do
    echo "  → ${name}-${w}.avif"
    ffmpeg -y -loglevel error \
      -i "$name.avif" \
      -vf "scale=${w}:-2" \
      -c:v libaom-av1 \
      -still-picture 1 \
      -crf 30 \
      -b:v 0 \
      "${name}-${w}.avif"
  done
done


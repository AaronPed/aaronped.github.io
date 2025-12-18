#!/usr/bin/env bash

set -euo pipefail

SRC="$HOME/Downloads"

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
done


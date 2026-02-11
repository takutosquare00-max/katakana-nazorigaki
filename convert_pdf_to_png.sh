#!/bin/bash
# katakana_nazorigaki2015.pdf を nazorigaki_images/ にPNG形式で出力
# 必要なもの: pdftoppm (poppler-utils)
# macOS: brew install poppler

set -e
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
cd "$SCRIPT_DIR"
mkdir -p nazorigaki_images

echo "Converting PDF to PNG..."
pdftoppm -png -r 150 katakana_nazorigaki2015.pdf nazorigaki_images/page

# pdftoppm が page-1.png 形式で出力する場合、page-01.png にリネーム
for f in nazorigaki_images/page-*.png; do
  [ -f "$f" ] || continue
  base=$(basename "$f" .png)
  num=${base#page-}
  if [ ${#num} -eq 1 ]; then
    mv "$f" "nazorigaki_images/page-0${num}.png"
  fi
done

echo "Done. PNG files are in nazorigaki_images/"

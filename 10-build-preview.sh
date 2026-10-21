#!/usr/bin/env bash
# build-preview.sh - reproducible TAARV WORKERS-PREVIEW asset build.
# Output must match the current live preview assets byte-for-byte.
# Base recipe mirrors .github/workflows/pages.yml (PRODUCTION recipe, unchanged),
# with these PREVIEW-SPECIFIC, DELIBERATE deviations:
#
#   1. WORDMARK TRANSFORM WHITELIST. Production's pages.yml applies a CSS sed to
#      every matching page. The live preview carries that transform on exactly
#      9 pages (earlier-era builds) and NOT on the 37 newer tool pages. Preview
#      appearance is preserved exactly as-is: the sed below applies ONLY to the
#      9 whitelisted files. Do not widen or drop this list without explicit
#      owner approval - either change visibly shifts taglines.
#
#   2. HOME PROMOTION: the true current home page ships in the zip chain as
#      home-next/index.html (override 440). The live preview serves that content
#      at BOTH /home-next/ and /. This script codifies the promotion:
#      cp home-next/index.html -> index.html (byte-identical, verified 2026-10-21).
#
#   3. AV STUDIO INCLUDED VIA CHUNKED WASM (override 464, verified 2026-10-21):
#      the original 1-nelvo-av-studio.zip ships vendor/ffmpeg-core.wasm at
#      30.7MB, over the 25MiB Workers asset limit. Override 464 ships the same
#      wasm split into 2 parts plus a manifest, and patches vendor/814.ffmpeg.js
#      to fetch and reassemble the parts in memory (it falls back to the single
#      file when no manifest exists). The monolithic wasm must NOT be deployed,
#      so it is deleted below after unzipping. Verified on the live preview:
#      audio + video conversions and subtitle repair through the actual UI, and
#      bounded failure states for unreadable and unconvertible files.
#
# Usage: run from the repo root on branch upgrade-staging. Output: ../public
set -euo pipefail
OUT="${1:-../public}"
rm -rf "$OUT"; mkdir -p "$OUT"

unzip -q 13-night-review-final.zip -d "$OUT"
for z in 1-nelvo-av-studio.zip 2-nelvo-gov-doc-sizer-gated.zip 2-taarv-small-header-r1.zip \
         1-taarv-master-preview.zip 1-taarv-script-fix.zip 2-taarv-visual-fix.zip \
         1-taarv-boundary-fix-r2.zip 1-1-taarv-boundary-fix-r2.zip 1-format-changer-deploy.zip; do
  unzip -qo "$z" -d "$OUT"
done
# all override zips, numeric by override number (stable)
for z in $(ls *override-*.zip | awk '{match($0,/override-[0-9]+/);print substr($0,RSTART+9,RLENGTH-9)" "$0}' | sort -n -s -k1,1 | cut -d' ' -f2); do
  unzip -qo "$z" -d "$OUT"
done

# PREVIEW DEVIATION 1: wordmark transform whitelist (see header)
for f in account/index.html festivalposter/index.html home/index.html          legal-draft/index.html login/index.html manifesto/index.html          poster-studio/index.html pricing/index.html usage-demo/index.html; do
  sed -i 's/width:830px;height:auto;max-width:100%;margin:auto/width:830px;height:auto;max-width:100%;margin:auto;transform:translateY(clamp(-24px,-2vw,-8px))/g' "$OUT/$f"
done

# logo + favicon steps (same as pages.yml)
cp *-logo-master-v3.png logo-master.png
cp *-logo-512-v3.png logo-512.png
cp *-favicon-64-v3.png favicon-64.png
python3 4-fav.py
python3 1-fav2.py
cp logo-512.png "$OUT/brand-logo.png"
cp logo-512.png "$OUT/brand-logo-white.png"

# PREVIEW DEVIATION 2: home promotion (see header)
cp "$OUT/home-next/index.html" "$OUT/index.html"

# PREVIEW DEVIATION 3: drop the over-limit monolithic wasm; chunked route (see header)
rm -f "$OUT/av-studio/vendor/ffmpeg-core.wasm"
test -f "$OUT/av-studio/vendor/ffmpeg-core.wasm.chunks.json" || { echo "av-studio chunk manifest missing"; exit 1; }
test ! -f "$OUT/av-studio/vendor/ffmpeg-core.wasm" || { echo "monolithic wasm still present"; exit 1; }

echo "build ok: $(find "$OUT" -type f | wc -l) files"

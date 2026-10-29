#!/bin/bash
# TAARV preview auth-negative gate - MUST PASS before any readiness/deploy claim.
# Usage: PREVIEW_PW=<password> ./auth-check.sh   (password stays out of the repo)
B=https://taarv-preview.sonarkatta.workers.dev
[ -n "$PREVIEW_PW" ] || { echo "set PREVIEW_PW first"; exit 2; }
fail=0
for p in / /colorlab/ /labels/ /pro/; do
  noauth=$(curl -s -o /dev/null -w '%{http_code}' "$B$p")
  bad=$(curl -s -o /dev/null -w '%{http_code}' -u 'taarv:wrong' "$B$p")
  ok=$(curl -s -o /dev/null -w '%{http_code}' -u "taarv:$PREVIEW_PW" "$B$p")
  printf '%-12s no-auth=%s bad-auth=%s auth=%s\n' "$p" "$noauth" "$bad" "$ok"
  [ "$noauth" = 401 ] && [ "$bad" = 401 ] && [ "$ok" = 200 ] || fail=1
done
a=$(curl -s -o /dev/null -w '%{http_code}' "$B/manifest.json")
printf '%-14s no-auth=%s (must be 401)\n' "/manifest.json" "$a"
[ "$a" = 401 ] || fail=1
[ $fail = 0 ] && echo AUTH-CHECK PASS || { echo AUTH-CHECK FAIL; exit 1; }

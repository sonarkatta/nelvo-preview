# TAARV preview - deployment record and rollback

Worker: taarv-preview (Cloudflare Workers Static Assets + gate worker).
Assets: built from the repo zip chain (10-build-preview.sh regenerates the 187 public files).

## Known-good
- 87864b42-61a9-4b41-a9f3-005dd32bed18 (2026-10-21T09:30Z) - override 467: narrow-header collision fixes at <=520px (posterstudio, catalogue, invitations), truthful qualified privacy copy across all 6 tools (local by default, account upload only on explicit Save), thumbnail account-restore guard fix (tool pagehide persist clobbered restored localStorage). auth-check.sh PASS after deploy.
  Source zip: 1-11-override-467-mobile-copy-fixes.zip, sha256 1baf4e10259f806d20740416e8de992c67c8518e4a793549fd24f13d89daff76 (remote hash verified equal; zip entries byte-match live-served pages).
- 6955156d-421b-4a31-8239-713947f8c983 (2026-10-21T09:05Z) - override 466: in-tool My account save/open for catalogue, biocraft, festivalposter, posterstudio, invitations, thumbnail. Save-wipe-open E2E PASS all 6. auth-check.sh PASS before and after deploy.
  Source zip: 1-10-override-466-account-save-6-tools.zip, sha256 553c6f2ad90b9b75fdae31bf414bc4b05d118901edaab0534767eebc1c5ba4f3 (remote hash verified equal after upload). Zip entries byte-match the deployed tree, and 10-build-preview.sh applies override zips in numeric override order, so 466 applies after 465 and last overall.
- fb86692d-9bfe-4fbb-8ec2-957e2dfd95bc (2026-10-21T07:57:05Z) - override 465 + run_worker_first=true. auth-check.sh PASS after deploy.
- Pre-465 user-side deployment: 3672e2db-b403-4165-a045-63821486c60b (2026-10-21T03:28:43Z).

## Incident (do not roll back to)
- 0a863408-c210-46fd-9c11-bd36594fb9de (07:56:36Z-07:57:05Z, 29.7s): wrangler [assets] default served assets before the worker, bypassing Basic auth on asset paths. Tool content was still AES ciphertext behind the in-page gate. No access logs exist for the window (logpush off, no tails; bypassed requests never invoked the worker).

## Hard rules learned
- [assets] needs explicit `run_worker_first = true` when the worker gates auth. Cloudflare settings/versions APIs do NOT round-trip this flag - keep it explicit here forever.
- Deploy only via `wrangler deploy` from this directory (complete wrangler.toml). Never raw API PUT without full bindings metadata.
- Run auth-check.sh after every deploy and before any readiness claim.

## Rollback
cd deploy && wrangler rollback --version-id <id>   # needs CLOUDFLARE_API_TOKEN + CLOUDFLARE_ACCOUNT_ID
then: PREVIEW_PW=<pw> ./auth-check.sh

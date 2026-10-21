# TAARV preview - deployment record and rollback

Worker: taarv-preview (Cloudflare Workers Static Assets + gate worker).
Assets: built from the repo zip chain (10-build-preview.sh regenerates the 187 public files).

## Known-good
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

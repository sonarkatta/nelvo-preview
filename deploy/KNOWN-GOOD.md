# TAARV preview - deployment record and rollback

Worker: taarv-preview (Cloudflare Workers Static Assets + gate worker).
Assets: built from the repo zip chain (10-build-preview.sh regenerates the 187 public files).

## Known-good
- 78a4f545-22a5-4c08-970f-597a8ffb55ec (2026-10-21T09:56Z) - override 470: pricing tab title "Packages - NELVO" -> "Packages | TAARV" and header logo alt -> "TAARV" (logo image already his TAARV crown mark; text-only, layout unchanged). auth-check.sh PASS after deploy; pricing page byte-matches live. (af1ab6f3 at 09:55Z was a content-identical redeploy of dd5bf582 from an aborted patch run - no content change.)
  Source zip: 1-14-override-470-pricing-title-brand.zip, sha256 4221826c3c9cc75020a80e23982067803fd8aaf85928f8f8a22f699ef7a876fd (remote hash verified equal).
- dd5bf582-44e3-42a6-abe9-a84f6181c89a (2026-10-21T09:46Z) - override 469: AV Studio stale Nelvo branding reconciled to TAARV (page title, header wordmark, footer; text-only, no layout change); size formatter shows bytes below 1 KB so small downloads no longer display "0 KB" (KB/MB formatting unchanged). auth-check.sh PASS after deploy; av-studio page byte-matches live.
  Source zip: 4-13-override-469-av-studio-branding-size.zip, sha256 e0fe876094edd06de78423702ba0f448589e8a2a040ec36b3c71659aec144375 (remote hash verified equal).
- 515980a6-687a-4bab-90ad-d5cb75a31b7b (2026-10-21T09:34Z) - override 468: invitations mobile header keeps Undo/Redo accessible (wrap instead of hide). auth-check.sh PASS after deploy.
  Source zip: 1-12-override-468-invitations-mobile-undo.zip, sha256 88d1935b2cd7a2227bc103bbc33ae882952280444934768c3f0ac79b8c4222f0 (remote hash verified equal; invitations page byte-matches live).
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

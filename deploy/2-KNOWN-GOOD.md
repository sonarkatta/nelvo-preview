# TAARV preview - deployment record and rollback

Worker: taarv-preview (Cloudflare Workers Static Assets + gate worker).
Assets: built from the repo zip chain (10-build-preview.sh regenerates the 187 public files).

## Known-good
- 395bf796-4be6-4420-b3f1-cd71e42a9970 (2026-10-21T10:14Z) - override 473: privacy copy sweep across 32 paths (31 encrypted tool pages + home index). Every visible absolute on-device claim on account-save tools now qualified ("unless you save to your account" style). Manifesto pillar "No uploads / Your files never leave your device" -> "No uploads by default / Files upload only when you choose to save them to your account". "No account walls / Sign-in is a choice, never a gate" retained - verified accurate against the current access model (every tool works signed-out; sign-in gates only Save). av-studio and poster-studio keep absolute copy (verified: no account save in either). Kept as always-true: download-file notes (billmint, biocraft, jobcard), local-draft/feature-state labels (bm-autosaved, subtitles project note), "Everything stays editable" feature notes. format-changer "No uploads" instances are JS comments, not rendered. /home/ confirmed isolated (no rendered inbound links; its stale claims are unreachable). privacy page already consistent ("We only keep files if you sign in and choose to save them"); terms carries no absolute privacy claims. auth-check.sh PASS; all 32 changed paths byte-match live. (8d663e2f, 36631e56, 0a7318d8 were superseded intermediate deploys of this same override minutes earlier.)
  Source zip: 17-override-473-privacy-copy-sweep.zip, sha256 6fd31c0710c49ccde1b67d5f78b40e23ef080e6464edc8920852a8443616c37c (remote hash verified equal).
- a1898edb-4bed-4d6e-a87c-4a5713fbd1d6 (2026-10-21T10:01Z) - override 472: usage-demo counter static text aligned with the JS ("3 sample uses left" / "0 / 3 sample used") so pre-click and post-click wording match. auth-check.sh PASS; page byte-matches live.
  Source zip: 2-16-override-472-demo-counter-consistency.zip, sha256 916b281daa2375c79ac30da7e44515b20d8d50807f6972ea6ea679ae95ac6048 (remote hash verified equal).
- 63baf1d4-d543-4b79-875c-3858523fcf68 (2026-10-21T09:59Z) - override 471: manifesto + usage-demo visible brand NELVO -> TAARV (titles, logo alts, eyebrows, manifesto body/footer line; DESIGN PREVIEW badges and preview notes preserved; layout unchanged). taarv-shell.js demo pill dead code simplified to "DEMO /" (the pill is display:none'd and removed by the shell itself at runtime - the "2 FREE USES LEFT" claim never rendered). auth-check.sh PASS; all three files byte-match live.
  Source zip: 1-15-override-471-manifesto-demo-brand.zip, sha256 e49808006995592f66cacfd2c4183172c4bd0ca62ccbb44777e372ae8d9dcaa1 (remote hash verified equal).
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

## Reachable placeholders and remaining gates (consolidated 2026-10-21, after 472)
Rendered reachability was verified in a real browser session (shadow-DOM shell header inspected), not only from code.

Reachable placeholders (linked as working features, actually samples):
- /pricing/ - "Packages" link in every tool page's shell header -> DESIGN PREVIEW, "Sample plan, not a live offer". Stays sample until approved package/payment work.
- /manifesto/ - "MANIFESTO" link in every tool page's shell header -> DESIGN PREVIEW page (brand now TAARV after 471; privacy pillar copy qualified in 473).

Effectively isolated (no rendered inbound links):
- /usage-demo/ - the shell demo pill is display:none'd and removed by the shell itself; only linked from the isolated /account/ page. Brand/quota wording corrected anyway (471/472).
- /account/ ("Welcome back, Alex" design sample; the working account feature is the in-tool pill from 466, unaffected), /home/, /legal-draft/ (legal design sample).

Remaining gates before any public launch (all unchanged, none approved):
- Real-device pass (iPhone + ASUS VivoBook), including the video export flow (video export UNVERIFIED: cloud-browser media pipeline hangs on any mp4, environment cause not conclusively established).
- Real PowerPoint file test (presentation-maker).
- Legal review/inclusion unresolved - do not fold legal-draft into launch.
- Packages/payment approval - pricing page stays sample, nelvo-monetization worker endpoint preserved as-is, MONETIZATION never enabled by agents.
- Explicit public GO from the user.

## Incident (do not roll back to)
- 0a863408-c210-46fd-9c11-bd36594fb9de (07:56:36Z-07:57:05Z, 29.7s): wrangler [assets] default served assets before the worker, bypassing Basic auth on asset paths. Tool content was still AES ciphertext behind the in-page gate. No access logs exist for the window (logpush off, no tails; bypassed requests never invoked the worker).

## Hard rules learned
- [assets] needs explicit `run_worker_first = true` when the worker gates auth. Cloudflare settings/versions APIs do NOT round-trip this flag - keep it explicit here forever.
- Deploy only via `wrangler deploy` from this directory (complete wrangler.toml). Never raw API PUT without full bindings metadata.
- Run auth-check.sh after every deploy and before any readiness claim.

## Rollback
cd deploy && wrangler rollback --version-id <id>   # needs CLOUDFLARE_API_TOKEN + CLOUDFLARE_ACCOUNT_ID
then: PREVIEW_PW=<pw> ./auth-check.sh

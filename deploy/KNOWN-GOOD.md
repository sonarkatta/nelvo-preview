# TAARV preview - deployment record and rollback

Worker: taarv-preview (Cloudflare Workers Static Assets + gate worker).
Assets: built from the repo zip chain (10-build-preview.sh regenerates the 187 public files).

## Known-good
- cd562d6f-77a3-4350-8309-9f4405a4c4f6 (2026-10-21T10:29Z) - override 474: fixed /nelvo-preview/ asset-path prefix (GitHub Pages remnant in the runtime brand script constants) that broke the crown logo on the 6 pages with content logos (account, home, legal-draft, manifesto, pricing, usage-demo); verified rendered on manifesto + pricing (naturalWidth 1954). Diagnosis correction for the record: real asset-prefix defect, not a cached-401/auth artifact. Removed manifesto's false "Only your free-use count is saved." claim (no replacement claim invented, no counters implemented). auth-check.sh PASS; all 6 changed paths byte-match live. (901aa959 was a partial intermediate deploy, superseded within a minute.)
  Source zip: 1-18-override-474-manifesto-logo-tracking.zip, sha256 48cef439dd72ca5d57f00909f11e70d46d9c14ad44786997cf61c78b61d6f57d (remote hash verified equal).
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
- f0e5b612-f52a-4078-9805-f2efec0eb2f3 (2026-10-21) - override 475: /pricing/ filled with the locked package baseline (Free 3 uses/tool; Single Tool Pass Rs79/$5 per month, monthly only as approved; Starter Rs149/$9 100 uses/mo; Pro Rs299/$19 500 uses/mo; Unlimited Rs599/$39; tiers yearly = 10x monthly; manual purchase, no auto-renew; monthly = 30 days / yearly = full year copy; sample-account claims qualified as preview). Not-live warnings + inert Buy kept; payments OFF. auth-check.sh PASS. INR/USD + monthly/yearly switches and desktop + mobile + yearly-mode pixels verified on live. Zip 1-override-475-pricing-locked-baseline.zip sha256 589ee4b56eeb6e3e773b6808f00d348beadfb37269a36646936f0036793d75db (commits 79b86858 + ac76d882, remote sha-verified).
- Pre-465 user-side deployment: 3672e2db-b403-4165-a045-63821486c60b (2026-10-21T03:28:43Z).

## Reachable placeholders and remaining gates (consolidated 2026-10-21, after 472)
Rendered reachability was verified in a real browser session (shadow-DOM shell header inspected), not only from code.

Reachable placeholders (linked as working features, actually samples):
- /pricing/ - "Packages" link in every tool page's shell header -> shows the LOCKED baseline prices/allowances since 475 (approved Oct 8 + Oct 10, see authority record below). Still marked not-a-live-offer: checkout off, Buy inert, payments OFF. Stays non-live until approved package/payment activation.
- /manifesto/ - "MANIFESTO" link in every tool page's shell header -> DESIGN PREVIEW page (brand now TAARV after 471; privacy pillar copy qualified in 473).

Effectively isolated (no rendered inbound links):
- /usage-demo/ - the shell demo pill is display:none'd and removed by the shell itself; only linked from the isolated /account/ page. Brand/quota wording corrected anyway (471/472).
- /account/ ("Welcome back, Alex" design sample; the working account feature is the in-tool pill from 466, unaffected), /home/, /legal-draft/ (legal design sample).

Remaining gates before any public launch (all unchanged, none approved):
- Real-device pass (iPhone + ASUS VivoBook), including the video export flow. Desktop pipeline VERIFIED 2026-10-22: audio (WAV -> MP3 192 kbps) and video (MP4 cut + re-encode) exports ran end-to-end on the live preview in cloud desktop Chrome through the real UI; the actual Download blobs were pulled from the page and verified locally with ffprobe/ffmpeg (valid MP3 and MP4, correct codecs/duration, clean full decode). Correction: the earlier 'cloud-browser media pipeline hangs on any mp4' note was Chrome deferring media load on an unfocused tab (readyState stuck 0), not a site defect; ffmpeg-core.wasm 404 is by design (chunked under override 464). Gate remains: real iPhone Safari + ASUS VivoBook pass still open.
- Real PowerPoint file test (presentation-maker). Partial progress 2026-10-21: pptx export structurally validated in cloud browser - valid OOXML, opens in python-pptx, multi-slide + bar chart + speaker notes + unicode (Devanagari, rupee) round-trip intact; gate stays open until a file is opened in the actual PowerPoint app on a real device.
- Legal review/inclusion unresolved - do not fold legal-draft into launch.
- Packages/payment approval - pricing page stays sample, nelvo-monetization worker endpoint preserved as-is, MONETIZATION never enabled by agents.
- Explicit public GO from the user.

## Packages and pricing authority record (recovered 2026-10-21)
Original approvals (verbatim, with message IDs). Baseline for any future package/payment work; unanswered later proposals do NOT change this baseline.

Lock 1 (2026-10-08, WhatsApp):
- 23:38:29 user wamid.HBgMOTE4NjY5ODQ4MDAwFQIAEhgUM0E0MUYxRTY3RTNCNzY3MzE2QzAA: "Price single 79 and Aple bakiche rates no other confusion"
- 23:38:41 agent wamid.HBgMOTE4NjY5ODQ4MDAwFQIAERgSOUUzNTRCNTZBNDI4RUMxNEFEAA==: "Locked: Free (3 uses/tool) + Single Tool 79/mo + 149/299/599 + world $9/19/39 + yearly 2 months free. No category packs, no confusion."
- 23:39:09 user wamid.HBgMOTE4NjY5ODQ4MDAwFQIAEhgUM0E0OTgyNTRENjgyRDdEMjY0RkUA: "Yes"
- Same evening: per-country packages rejected by user ("All countries different packages" 23:11:17 -> 2-tier INR/USD); INR and USD never shown together (user 23:14:12).

Lock 2 (2026-10-10, iMessage; refines Lock 1):
- 23:24:30 agent phonemsg-01M4KF7F7D71R8R1528WV0SAG6: FREE 3 uses/tool (account); SINGLE 79/$5 one tool 30 days; STARTER 149/$9 100 uses/mo; PRO 299/$19 500 uses/mo; UNLIMITED 599/$39 limitless; manual purchase, no auto-renew. 23:24:31 agent: "He ok asel tar 'ok' kar".
- 23:25:54 user phonemsg-01M4KFA2A5FPPBRFWESXFQP1KD: "599 per year ka month" -> 23:26:00 agent: monthly; year = 10x monthly = 5,990/yr (2 months free), manual, no auto-renew.
- 23:26:30 user phonemsg-01M4KFB5317CEHH5V789VAJSD7: "Ok". 23:26:36 agent: "Packages lock!"
- 23:32:23 agent stated 2 conditions (later AI/cloud tools excluded; Unlimited = personal use, no auto/resale) - agent-stated, not objected to; NOT user permission by itself.

Later user restrictions (2026-10-19, WhatsApp):
- 23:35:36 user wamid.HBgMOTE4NjY5ODQ4MDAwFQIAEhgUM0FCOTUyQzFGQTJDODhCOUVCMTcA: "But we are not free"
- 23:37:41 user wamid.HBgMOTE4NjY5ODQ4MDAwFQIAEhgUM0FDRTQzRDgwMThCMUVFNkYzNjEA: "Mg sagle freech waprat bastil paid kashala ghetil"
- Agent 23:37:51 proposed small daily free taste (2-3 uses/day, HD/batch/bulk/history in Pro), asked "Chalel?" - NO user confirmation on record.

Genuinely open (only these):
- Free-tier reset semantics (locked "3 uses/tool" states no reset period; daily-reset and PDF-specific daily taste were proposed, never confirmed).
- Razorpay International Payments ON (requested of user 2026-10-19 10:18:22 and 23:04:47; no confirmation on record).
- Final GO.

Source limitations (2026-10-21 live vault check):
- Vault holds "Nelvo Razorpay LIVE API" (rzp_live_ Key ID + secret, both populated) and "Nelvo Razorpay TEST API" (both populated). Do not ask user to re-add keys.
- Whether the live keys are still active in Razorpay, account KYC status, and International Payments state are UNVERIFIED (key presence in vault is not equivalent to active/approved account state; no Razorpay dashboard credentials in vault).
- Unanswered 2026-10-15 proposal (99/mo or 799/yr, $2.49/$19.99, 3 uses/tool/day, drop password gate) does not revoke or modify the locks above.
- Payments stay OFF; MONETIZATION never enabled by agents; no account creation by agents.

## Incident (do not roll back to)
- 0a863408-c210-46fd-9c11-bd36594fb9de (07:56:36Z-07:57:05Z, 29.7s): wrangler [assets] default served assets before the worker, bypassing Basic auth on asset paths. Tool content was still AES ciphertext behind the in-page gate. No access logs exist for the window (logpush off, no tails; bypassed requests never invoked the worker).

## Hard rules learned
- [assets] needs explicit `run_worker_first = true` when the worker gates auth. Cloudflare settings/versions APIs do NOT round-trip this flag - keep it explicit here forever.
- Deploy only via `wrangler deploy` from this directory (complete wrangler.toml). Never raw API PUT without full bindings metadata.
- Run auth-check.sh after every deploy and before any readiness claim.

## Rollback
cd deploy && wrangler rollback --version-id <id>   # needs CLOUDFLARE_API_TOKEN + CLOUDFLARE_ACCOUNT_ID
then: PREVIEW_PW=<pw> ./auth-check.sh

## 2026-10-22 - Export battery: 19 tool export paths verified on preview (390px emulation)
All 19 battery tools produced a real export blob captured in-page (hooked URL.createObjectURL) and validated locally (ffprobe/PIL/PDF header+%%EOF; QR decoded to the exact input URL): qrforge, certificate, chartmint, menumaker, marriagebio, specsheet, screenshots, jobcard, teacherkit, labels, societynotice, goldbook, gov-doc-sizer, goldrate, billmint, colorlab, kidspractice, printdesk, format-changer. AV Studio audio+video exports verified separately with ffprobe (MP4 h264/aac decodes, MP3 192kbps decodes).
Corrections to earlier stuck-export observations (automation timing/flow, not defects): kidspractice export buttons enable only after paint() finishes (fonts/render wait); printdesk Download is a no-op until Generate runs (outs==null); format-changer needs a target-format chip selected and delivers results into an in-page history list (no auto-download).
Scope: 19 export paths verified; this is NOT an all-37-pages export test. The 37-page phone-layout sweep (zero horizontal overflow) was 390px emulation, not a real device.

## 2026-10-23 - override 476: Format Changer chip overlap + Poster Studio Marathi font fallback (deploy 4cc5c685-d870-4bae-94d2-13f2e31e75a3)
- format-changer: decorative fc-cloud chips SVG (left 33%->14%) and TXT (right 35%->15%) moved off the centered bottom legend (PDF..CDR); overlap verified live before (screenshots), cleared after (pixel-checked 1280px). Layout/design otherwise untouched.
- posterstudio: Marathi-in-"Great Vibes (Marathi/Hindi)" rendered in a system serif at normal weight because the Kalam fallback was embedded/preloaded at 700 only (fontStr uses 400 unless bold). Added embedded Kalam 400 (devanagari + latin subsets, Google Fonts OFL, same unicode-ranges as the existing 700 faces) and FAMS preload ['Kalam',[700]] -> [400,700]. Latin still renders Great Vibes (first in stack). Verified live: document.fonts.check 400 Kalam Devanagari+Latin true; canvas measureText('नमस्ते') Vibes-stack == pure-Kalam width exactly (150.27px vs serif 136.58); offscreen render visually identical to Kalam row. businesscard + invitations checked: their vibes stacks already fall to embedded Noto Serif/Sans Devanagari 400 - no defect there. Scope: posterstudio only.
- Sticker Maker header "My account -> /pricing/" report from 11:44 QA was a coordinate mis-click (Packages link x=933-1014, My account button x=1022+; the QA click at x=1013 hit Packages). Verified live: My account BUTTON opens the real account modal (My saved files / Packages / Sign out) with no navigation. Not a defect; no change shipped.
- zip sha256: 4018bea144e36c85c6af75493a34288c081387ed3584760ee8090eb12168a650. auth-check.sh PASS; both changed pages byte-match live.

## 2026-10-23 12:22 IST - av-studio export stall watchdog (override 477)
- Change: engine-load timeout 180s + exec timeout 900s with visible error via existing fail(); failed engine load no longer poisons retry (ffP reset on rejection when engine never became ready). No design/output/auth/payment changes. Commit 388f3f1.
- Why: export could stall indefinitely with only "Exporting... keep this tab open" (observed in cloud-browser hidden-tab test; real-user strand risk on stalled load/exec).
- Live verification: normal MP4 export still passes (qa-clip 22211B -> 23415B video/mp4, in 2s); readiness gate confirmed (Export disabled until metadata loaded); withT watchdog unit-verified live; retry-recovery verified by code inspection (live simulation inconclusive - worker-internal load not interceptable from page scope).
- Deploy: taarv-preview version 1815316d-3169-46d2-921b-f7547fbf5cf6, auth-check PASS. Payments OFF, private gate intact.

## 2026-10-23 19:55 IST - export battery wave 2: all 18 remaining pages covered
Wave-1 (Oct 22) covered 19 export paths; wave 2 covers the OTHER 18 pages (36 home tiles + /invoiceos/ = 37-page denominator; av-studio separate). All 18 produced a real captured export blob, locally validated (file/PIL/python-pptx/unzip): biocraft (HTML), catalogue (PDF), festivalposter (PNG), ratecard (PNG), posterstudio (PNG), signstamp (PNG), sticker-maker (PNG), logo-designer (PNG), thumbnail (PNG), gsm-calculator (CSV), invoiceos (HTML report), background-remover (PNG), pro/Photo Studio (JPEG render), pdf-studio (PDF 1.7), subtitles (fixed-SRT zip), businesscard (front PNG), presentation-maker (pptx opens in python-pptx), invitations (PNG).
FOLLOW-UP CLOSED (Oct 23 ~20:02 IST): subtitles single-file export VERIFIED working - earlier probe clicked the wrong control. Control flow traced from source: top Export (#st-expgo) only opens the export pane; format chips (#fmts [data-fmt]) are selection-only (set S.fmt); the actual single-file export is the per-file row Save button ([data-ex="save"]) which calls save(blob,name) (anchor download), and the top Download button (#st-zip) runs the same save() path when 1 file is loaded, ZIP when >1. Live test: uploaded qa-single.srt, clicked [data-ex="save"], captured exactly 1 blob download (script.fixed.srt) containing valid SRT with the synthetic marker "ZXQ-7766-Verifier first marker line." and normalized timings. Verified scope: ZIP path + single-file SRT save only; other output formats (VTT/ASS/SBV/TTML/CSV/TXT) and Transcript/Copy/Preview row actions remain untested surfaces in the ledger. Note: the tool restores prior uploads from IndexedDB on load - future probes must clear test IDB state first so restored rows cannot blur input/output attribution.
Page->feature ledger with untested secondary surfaces: taarv-masters-backup TAARV-verification/20261023-1931-export-batt2/RESULTS.md. Cloud emulation, not real devices; gates unchanged (real device, PowerPoint app, payments OFF, no GO).

Wave 3 (Oct 23 ~20:05-20:20 IST) - secondary export surfaces, same capture/validation rigor: subtitles (all ledger surfaces tested) (VTT/ASS/SBV/TTML/CSV/TXT + Transcript/Copy/Preview all verified with unique-marker input; note: tool restores prior uploads from IndexedDB - attribute by filename prefix). ratecard (all ledger surfaces tested) (JPG, PDF; chooser labels "Picture (PNG)/Photo (JPG)/Document (PDF)"). posterstudio: JPG, PDF, quality 2x (dims verify scale), transparent PNG (RGBA alpha 0-255), multi-size ZIP presets x2 variants verified; 1x/3x same code path untested; Copy/Share untested. signstamp (all ledger surfaces tested) (On-white PNG white-verified, stamp PNG+SVG with test strings, signed-doc JPG+PDF; doc export requires a placed item by design). logo-designer (all ledger surfaces tested) (SVG, PDF, PNG-white, brand-kit ZIP 5 entries; PNG-white was an extra surface beyond ledger). thumbnail (all ledger surfaces tested) (JPG; YouTube JPG byte-identical to JPG since <2MB already satisfied - by design; multi-size pack ZIP extra surface tested). businesscard (ledger surfaces tested; 5 extra untested surfaces found) (Back PNG, Print sheet PDF 2pg, Print-shop PDF w/bleed 2pg, card-pack ZIP 7 entries; extra untested surfaces found: Both-sides share, vcf, Save PNG, Save PDF, Save design file). Artifacts + full ledger: taarv-masters-backup TAARV-verification/20261023-wave3-secondary/ (commit 76dac6c).

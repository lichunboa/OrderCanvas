# OrderCanvas · Approved brand identity

**Owner-approved and frozen:** 2026-10-15 · refined Concept A (OC monogram).

The only approved reference is the **second refined OrderCanvas visual identity board**, with a white/silver `O`, blue-to-cyan `C`, **two blue candlesticks inside the O**, and a midnight-blue background. Do not replace it with later AI-generated variations or unrelated badges (including glowing-ring alternatives).

## Identity
- Brand: **OrderCanvas**
- Product: **OrderCanvas for MT5**
- EN tagline: **Trade Smarter. Right on Your Chart.**
- ZH tagline: **在图表上，更简单地交易**
- Primary blue: `#2563FF`; cyan: `#22C5E5`; midnight navy: `#0F172A`; light: `#F8FAFC`
- Success `#10B981`, risk `#EF4444` are UI states, *not* replacement logo hues.

## Reference integrity
- Approved design board: `approved_styleboard.png`
- SHA-256: `34084c55049de0a22ae2f9bb8c10f644be746bfe05e0a65d05651b6c4aad9bb6`
- Approved raster export names: `logo-dark.png`, `logo-light.png`, `icon-512.png`, `icon-192.png`, `apple-touch-icon.png`, `icon-48.png`, `icon-32.png`, `favicon.ico`.
- Preview files are *raster reference crops*, not true SVG masters. A future transparent/true-vector source needs geometry verification before it can supersede these approved previews.

## Destinations / ownership
| Surface | Correct asset | Notes |
|---|---|---|
| H5 website and buyer/seller navigation | `logo-dark.png` / `logo-light.png` | Pick by actual background contrast |
| H5 favicon and mobile shortcut | `favicon.ico`, `icon-32.png`, `apple-touch-icon.png`, `icon-192.png` | Maintain path-prefix compatibility under `/oc` |
| GitHub README | dark/light horizontal logo | Keep the real MT5 product screenshot separately |
| GitHub repository social preview | approved visual reference adapted for wide card | Requires repository settings/API support; not equivalent to changing profile avatar |
| Telegram bot / channel / group avatars | `icon-512.png` | Group/channel changes require appropriate admin access; bot photo normally via BotFather |
| MT5 installer / package / product download | square icon | No trading or license code change |
| MQL5 product listing / support docs | logo + real application screenshots | Do not imply MetaQuotes endorsement |
| Release announcement / video / FAQ | approved lockup | Avoid performance claims or fictional trades |

## Engineering integration contract
Keep the approved files in a **single canonical project-owned brand directory**, then copy/build derivatives for each consumer. Never create multiple independently maintained logo designs in separate H5, MT5 or GitHub worktrees. Preserve the source image SHA, asset file names and visible geometry.

**Repository assets now present:** original approved reference raster files at [assets/brand](../assets/brand). Both README files use `assets/brand/logo-dark.png` as the header image. These are the exact approved raster preview exports rather than AI-redesigned variants.

**Deployment status:** GitHub repository asset import and README replacement are complete; H5 runtime deployment, GitHub repository social-preview setting, Telegram avatars, native MT5 binaries, and MQL5 listing images remain separate verifiable actions.
